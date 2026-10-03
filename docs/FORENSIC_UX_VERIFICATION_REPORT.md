# FORENSIC UX VERIFICATION REPORT (ROUND 2: CLOSURE)

## 1. Executive Summary

تم استكمال الجولة الثانية من التدقيق الجنائي لتجربة المستخدم (Round 2 Forensic Trace). 
الهدف الأساسي من هذه النسخة هو الاستناد المطلق إلى الأدلة القطعية وإغلاق فجوات الاستنتاج، وتخفيض الثقة لأي نقطة غير مدعمة بدليل برمجي واضح، بالإضافة إلى دراسة إمكانيات البنية التحتية لتنفيذ التوصيات المقترحة بأمان. 

بناءً على التتبع الفعلي:
- **Partial Import:** مدعوم فعلياً من قاعدة البيانات، لكن محظور من طبقة الـ Provider.
- **Context:** هو المصدر الحقيقي الوحيد للحقيقة مدعوماً بـ `ContextPreferences`.
- **Question Editor:** الواجهة مسطحة تماماً (Flat) ولا تطبق أي نوع من الإخفاء التدريجي (Progressive Disclosure).
- **Error Handling:** استثناءات النظام (Raw Exceptions) معروضة للمستخدم مباشرة في كل ميزات التطبيق.

لا ينبغي البدء بتنفيذ أي واجهة مستخدم (UI) قبل اعتماد هذه الحقائق كنقطة انطلاق.

---

## 2. Document Verification Matrix (Updated)

| Document Claim | Status | Evidence | Notes |
| -------------- | ------ | -------- | ----- |
| السياق هو مصدر الحقيقة المركزي | VERIFIED | `app_providers.dart` (Lines 29-33) + `ContextPreferences` | الـ `DashboardProvider` وميزات أخرى تراقب `ContextProvider` بشكل مباشر. |
| Dashboard Alerts غير تفاعلية | VERIFIED | `alerts_banner.dart` (Line 52-57) | أيقونة `close` فقط مع تعليق `// Dismiss alert`، لا يوجد حدث `onTap` للبطاقة. |
| الاستيراد يرفض العمل بوجود خطأ | VERIFIED | `student_import_provider.dart` (Line 64) | حظر صريح بـ `if(_validationErrors.isNotEmpty) return false;` |
| الاستيراد الجزئي ممكن برمجياً | VERIFIED | `student_repository.dart` (Line 173) | داخل `database.transaction`، الـ `catch(e)` يمنع انهيار العملية بالكامل ويكمل الدوران (Loop)، مما يعني أن الـ Valid Rows تُحفظ فعلاً إذا سُمح لها بالمرور. |
| رسائل الخطأ تعرض الـ Exception مباشرة | VERIFIED | `grep` بحث للـ `catch(e)` | أكثر من 20 موضعاً في الـ Providers يمررون `$e` مباشرة إلى الـ UI. |

---

## 3. Deep Forensic Traces

### 3.1. Student Import — Partial Import Evaluation
**المسار الفعلي:**
`StudentImportPage` → `StudentImportProvider.importStudents()` → `StudentRepository.importStudents()` → `database.transaction()`.

**سلوك الحفظ (Persistence Behavior):**
داخل `StudentRepository.importStudents()` (السطور 147-178)، يتم عمل حلقة `for` لكل طالب داخل `transaction`. 
هناك `try-catch` داخل الحلقة. إذا فشل طالب معين، يتم التقاط الخطأ (`catch`) وتتم زيادة عداد `failed++` دون عمل `rethrow`.
**النتيجة المؤكدة:** طبقة البيانات (Drift Database) **تدعم تماماً (Safely Supports)** حفظ 480 طالب صحيح ورفض 20 خاطئ. سبب المنع الحالي هو فقط طبقة `StudentImportProvider` التي ترفض تمرير القائمة للمستودع (Repository) من الأساس إذا كان هناك خطأ واحد. 
**Status:** SAFE TO IMPLEMENT PARTIAL IMPORT.

### 3.2. Context Source of Truth Verification
**المصادر التي تم تتبعها:**
- `ContextPreferences`: يتعامل مع الـ SharedPreferences بشكل مباشر للحفظ والاسترجاع (يُستخدم في `ContextProvider` و `SplashScreen`).
- `ContextProvider`: الـ Provider الوحيد المسؤول عن قراءة `ContextPreferences` في `loadAll()`. 
- `AppProviders`: يتم حقن `ContextProvider` كحالة عامة للبرنامج، و`DashboardProvider` يعتمد عليه كلياً (`ChangeNotifierProxyProvider`).
**الاستنتاج:** `ContextProvider` هو الـ (Single Source of Truth) الفعلي. ولا توجد نسخ مكررة من حالة السياق تدار خارج هذا المزود. 

### 3.3. Question Editor — Behavior Matrix
استناداً إلى `QuestionEditorPage` (السطور 131-146):
| Question Type | Visible Fields | Scientific Tools | Marks | Difficulty | Explanation |
| ------------- | -------------- | ---------------- | ----- | ---------- | ----------- |
| Multiple Choice | السؤال، الخيارات | ظاهرة دائماً | ظاهرة دائماً | ظاهرة دائماً | غير موجودة |
| True/False | السؤال، الخيارات | ظاهرة دائماً | ظاهرة دائماً | ظاهرة دائماً | غير موجودة |
| Essay | السؤال، الإجابة (نص) | ظاهرة دائماً | ظاهرة دائماً | ظاهرة دائماً | ظاهرة دائماً |

**الاستنتاج:** أدوات (رياضيات/كيمياء/فيزياء) وإعدادات (الصعوبة والدرجة) ليست مرتبطة بنوع السؤال، وتظهر للجميع بشكل مسطح. الـ Progressive Disclosure يجب أن يكون كـ **General Advanced Settings** (لأن الأدوات عامة وليست مخصصة لنوع محدد).

### 3.4. Alerts Deep Trace
- **المصدر:** يتم توليد التنبيهات في `DashboardProvider._fetchDashboardData()` السطور (117-126). 
- **المعنى الحالي:** تنبيه "درجات غير مدخلة" إذا كان الاختبار منتهياً وحالته 'draft'.
- **سلوك واجهة المستخدم:** التنبيه يُمرر إلى `AlertsBanner`، وكل تنبيه يعرض العنوان والنص وزر إغلاق وهمي فقط.
- **التوجيه المطلوب:** لا توجد وجهة (Destination) أو إجراء (Action) مبرمج في الكود الحالي للانتقال لتصحيح الاختبار. 

### 3.5. Error Handling Scope
استناداً إلى تتبع الكتل البرمجية `catch(e)` في جميع الميزات:
| Feature | Error Source | Current UI Message | Raw Exception Exposed? | Recovery |
| ------- | ------------ | ------------------ | ---------------------- | -------- |
| Context | Repository / Storage | `فشل في تحميل السياق: $e` | **YES** | إعادة تحميل |
| Exams | Save / Validate | `فشل في حفظ الاختبار: $e` | **YES** | Retry يدوي |
| Students | Import Provider | `فشل في قراءة الملف: $e` | **YES** | رفع ملف جديد |
| Backup | File System | `$e` | **YES** | لا يوجد |

**الاستنتاج:** معالجة الأخطاء ضعيفة جداً من منظور الـ UX (كل استثناء يظهر للمستخدم الخام). 

### 3.6. Navigation Closure
- **الاحتفاظ بالحالة عند التراجع (State Preservation on Back):**
  - **Exams:** عند عمل Pop من `ExamEditorPage` يتم حفظ الاختبار كمسودة دورياً كل 30 ثانية (Auto-save). ومع ذلك، حالة واجهة المستخدم في `ExamProvider` قد تُفقد وتُعاد تهيئتها عند فتح الصفحة لاحقاً.
  - **Student Import:** الـ `StudentImportProvider` يتم إنشاؤه داخل `build` في `StudentImportPage` السطر (19). أي خطوة Back ستؤدي إلى **ضياع كل تقدم الاستيراد ومسح الذاكرة**.

---

## 4. Implementation Readiness

بناءً على الأدلة المغلقة في هذا التقرير، هذه هي حالة جاهزية التدفقات للتنفيذ التقني:

| Phase | Objective | Evidence Complete? | Safe To Implement? |
| ----- | --------- | ------------------ | ------------------ |
| **UX-3** | **Partial Student Import** | **YES** (Drift supports it safely) | **YES** |
| **UX-2** | **Question Editor Disclosure** | **YES** (Current UI is flat) | **YES** |
| **UX-4** | **Error Message Parsing** | **YES** (All raw exceptions identified)| **YES** |
| **UX-1** | **Actionable Alerts** | **YES** (Alerts logic is verified) | **YES** (Requires adding routing to alerts) |

*(نهاية الجولة الثانية للتدقيق الجنائي لتجربة المستخدم - بانتظار الموافقة لبدء التنفيذ)*
