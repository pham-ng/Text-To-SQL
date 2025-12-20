USE HOCSINHDB;

#Ví dụ 1: Cho biết số lượng giáo viên của toàn trường
SELECT COUNT(*)
FROM GIAOVIEN;

#Ví dụ 2: Cho biết số lượng giáo viên của bộ môn HTTT
SELECT COUNT(MAGV)
FROM GIAOVIEN
WHERE MABM = 'HTTT';

#Ví dụ 3: Tính số lượng giáo viên có người quản lý về mặt chuyên môn
SELECT COUNT(GVQLCM)
FROM GIAOVIEN;

SELECT COUNT(*)
FROM GIAOVIEN
WHERE GVQLCM IS NOT NULL;

#Ví dụ 4: Tính số lượng giáo viên làm nhiệm vụ quản lý chuyên môn cho giáo viên khác
# mà thuộc bộ môn HTTT
SELECT COUNT(distinct(GVQLCM))
FROM GIAOVIEN GV
JOIN BOMON BM ON GV.MABM=BM.MABM
WHERE BM.TENBM ='Hệ thống thông tin';


#Ví dụ 5: Tính lương trung bình của giáo viên bộ môn Hệ thống thông tin
SELECT AVG(GV.LUONG)
FROM GIAOVIEN GV
JOIN BOMON BM ON BM.MABM=GV.MABM
WHERE BM.TENBM='Hệ thống thông tin';

#Ví dụ 6: Với mỗn bộ môn cho biết bộ môn (MAMB) và số lượng giáo viên của bộ môn đó.
SELECT GV.MABM, COUNT(*) AS SO_LUONG_GV
FROM GIAOVIEN GV
GROUP BY GV.MABM;

#Ví dụ 7: Với mỗi giáo viên, cho biết MAGV và số lượng công việc mà giáo viên đó có tham gia.
SELECT GV.MAGV,GV.HOTEN,COUNT(TGDT.MADT)
FROM GIAOVIEN GV 
LEFT JOIN THAMGIADT TGDT ON GV.MAGV=TGDT.MAGV
GROUP BY GV.MAGV,GV.HOTEN;


#Ví dụ 8: Với mỗi giáo viên, cho biết MAGV và số lượng đề tài mà giáo viên đó có tham gia.
SELECT TGDT.MAGV, COUNT(DISTINCT TGDT.MADT) AS SO_LUONG_DE_TAI
FROM THAMGIADT TGDT
GROUP BY TGDT.MAGV;

#Ví dụ 9: Với mỗi bộ môn, cho biết số đề tài mà giáo viên của bộ môn đó chủ trì
SELECT BM.TENBM, COUNT(DISTINCT DT.MADT) AS SO_LUONG_DT
FROM BOMON BM
JOIN GIAOVIEN GV ON BM.MABM=GV.MABM
JOIN DETAI DT ON DT.GVCNDT=GV.MAGV
GROUP BY BM.MABM ,BM.TENBM;


#Ví dụ 10: Với mỗn bộ môn cho biết tên bộ môn và số lượng giáo viên của bộ môn đó.
SELECT BM.MABM,BM.TENBM ,COUNT(MAGV) AS SO_LUONG_GV
FROM BOMON BM
JOIN GIAOVIEN GV ON BM.MABM=GV.MABM
GROUP BY BM.MABM,BM.TENBM;


#Ví dụ 11: Cho biết những bộ môn từ 2 giáo viên trở lên
SELECT BM.MABM, BM.TENBM, COUNT(*) AS SO_LUONG_GV
FROM GIAOVIEN GV
JOIN BOMON BM ON GV.MABM=BM.MABM
GROUP BY BM.MABM
HAVING COUNT(GV.MAGV)>2;


#Ví dụ 12: Cho tên những giáo viên và số lượng đề tài của những GV tham gia từ 3 đề tài trở lên.
SELECT GV.MAGV,GV.HOTEN, COUNT(DISTINCT TGDT.MADT) AS SO_LUONG_DE_TAI
FROM GIAOVIEN GV
JOIN THAMGIADT TGDT ON GV.MAGV=TGDT.MAGV
GROUP BY GV.MAGV
HAVING COUNT(distinct TGDT.MADT)>=2;

#Ví dụ 13: Cho biết số lượng đề tài được thực hiện trong từng năm.
SELECT YEAR(NGAYBD) AS NAM,COUNT(*) AS SO_LUONG_DE_TAI
FROM DETAI DT
GROUP BY YEAR(NGAYBD);

#Q27. Cho biết số lượng giáo viên viên và tổng lương của họ
SELECT COUNT(GV.MAGV),SUM(LUONG) AS TONG_LUONG
FROM GIAOVIEN GV;

#Q28. Cho biết số lượng giáo viên và lương trung bình của từng bộ môn.
SELECT BM.MABM,BM.TENBM,COUNT(GV.MAGV),AVG(GV.LUONG)
FROM GIAOVIEN GV
JOIN BOMON BM ON GV.MABM=BM.MABM
GROUP BY BM.MABM,BM.TENBM;



#Q29. Cho biết tên chủ đề và số lượng đề tài thuộc về chủ đề đó.
SELECT CD.MACD,CD.TENCD,COUNT(DISTINCT DT.MADT)
FROM CHUDE CD
JOIN DETAI DT ON CD.MACD=DT.MACD
GROUP BY CD.MACD,CD.TENCD;

#Q30. Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó tham gia.

SELECT GV.MAGV,GV.HOTEN,COUNT(DISTINCT TGDT.MADT)
FROM GIAOVIEN GV
JOIN THAMGIADT TGDT ON GV.MAGV=TGDT.MAGV
GROUP BY GV.MAGV,GV.HOTEN;

#Q31. Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó làm chủ nhiệm.
SELECT GV.MAGV,GV.HOTEN,COUNT(DISTINCT DT.MADT) AS SO_LUONG_DE_TAI_CN
FROM GIAOVIEN GV
JOIN DETAI DT ON GV.MAGV=DT.GVCNDT
GROUP BY GV.MAGV,GV.HOTEN;



#Q32. Với mỗi giáo viên cho tên giáo viên và số người thân của giáo viên đó
SELECT GV.MAGV,GV.HOTEN,COUNT(NT.MAGV) AS SO_LUONG_NGUOI_THAN
FROM GIAOVIEN GV
JOIN NGUOITHAN NT ON GV.MAGV=NT.MAGV
GROUP BY GV.MAGV,GV.HOTEN; 


#Q33. Cho biết tên những giáo viên đã tham gia từ 3 đề tài trở lên.
SELECT GV.MAGV,GV.HOTEN,COUNT(DISTINCT TGDT.MADT) AS SO_LUONG_DE_TAI
FROM GIAOVIEN GV
JOIN THAMGIADT TGDT ON GV.MAGV=TGDT.MAGV
GROUP BY GV.MAGV,GV.HOTEN
HAVING COUNT(DISTINCT TGDT.MADT)>=3;



#Q34. Cho biết số lượng giáo viên đã tham gia vào đề tài Ứng dụng hóa học xanh.
SELECT COUNT(DISTINCT GV.MAGV) AS SO_LUONG_GV_THAM_GIA 
FROM GIAOVIEN GV 
JOIN THAMGIADT TGDT ON GV.MAGV=TGDT.MAGV 
JOIN DETAI DT ON DT.MADT=TGDT.MADT 
WHERE DT.TENDT='Ứng dụng hóa học xanh'




