-----------------MERGE--------------------------


 تُستخدم لدمج البيانات من جدول مصدر -1
 (Source) مع جدول هدف (Target).

الهدف: إدخال أو تحديث البيانات في خطوة واحدة -2


--الصيغة الاساسية لها 

MERGE INTO TargetTable AS T
USING SourceTable AS S
ON T.PrimaryKey = S.PrimaryKey
WHEN MATCHED THEN
    UPDATE SET T.Column1 = S.Column1, T.Column2 = S.Column2
WHEN NOT MATCHED THEN
    INSERT (Column1, Column2)
    VALUES (S.Column1, S.Column2);




Examble……….

MERGE INTO Doctor AS D
USING NewDoctors AS N
ON D.DoctorID = N.DoctorID
WHEN MATCHED THEN
    UPDATE SET D.Phone = N.Phone, D.Email = N.Email
WHEN NOT MATCHED THEN
    INSERT (DoctorID, Name, Email, Phone, Specialty, YearsOfExperience)
    VALUES (N.DoctorID, N.Name, N.Email, N.Phone, N.Specialty, N.YearsOfExperience);

