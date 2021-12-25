-- execution : 7 ms
SELECT 현재활동인부서의_관리자_연봉_top5.사원번호, 사원.이름, 현재활동인부서의_관리자_연봉_top5.연봉, 현재직급.직급명, 사원퇴실기록.지역, 사원퇴실기록.입출입구분, 사원퇴실기록.입출입시간
FROM (
         SELECT 현재부서관리자.사원번호, 현재사원연봉.연봉
         FROM (SELECT 사원번호, 부서번호 FROM 부서관리자 WHERE 종료일자 = '9999-01-01') AS 현재부서관리자
                  INNER JOIN (SELECT 부서번호 FROM 부서 WHERE 비고 = 'ACTIVE') AS 현재활동중인부서 ON 현재부서관리자.부서번호 = 현재활동중인부서.부서번호
                  INNER JOIN (SELECT 연봉, 사원번호 FROM 급여 WHERE 종료일자 = '9999-01-01') AS 현재사원연봉 ON 현재부서관리자.사원번호 = 현재사원연봉.사원번호
         ORDER BY 현재사원연봉.연봉 DESC LIMIT 5
     ) AS 현재활동인부서의_관리자_연봉_top5
         INNER JOIN (SELECT * FROM 직급 WHERE 종료일자 = '9999-01-01') AS 현재직급 ON 현재활동인부서의_관리자_연봉_top5.사원번호 = 현재직급.사원번호
         INNER JOIN 사원 ON 현재활동인부서의_관리자_연봉_top5.사원번호 = 사원.사원번호
         INNER JOIN (SELECT 사원번호, 입출입시간, 입출입구분, 지역 FROM 사원출입기록 WHERE 입출입구분 = 'O') AS 사원퇴실기록
                    ON 현재활동인부서의_관리자_연봉_top5.사원번호 = 사원퇴실기록.사원번호
;