/* EOY Enrollment Report FTE Validation Script */

/* Vocation */
SELECT a.dsc_term_code,
       'Budget Residents' AS category,
       round(sum(sc_att_cr) / 150 + sum(nvl(sc_contact_hrs, 0)) / 450, 2) AS vocational
  FROM bailey.student_courses a
       LEFT JOIN bailey.courses b
                 ON b.dc_crn = a.dsc_crn AND b.dsc_term_code = a.dsc_term_code
       LEFT JOIN bailey.students03 c
                 ON c.dsc_pidm = a.dsc_pidm AND c.dsc_term_code = a.dsc_term_code
 WHERE a.dsc_term_code IN ('20193E', '20194E', '20202E')
   AND b.c_program_type = 'V'
   AND b.c_budget_code LIKE 'B%'
   AND c.s_regent_res IN ('R', 'A', 'M')
 GROUP BY a.dsc_term_code
ORDER BY a.dsc_term_code;


/* Upper Division */
SELECT a.dsc_term_code,
       'Budget Residents' AS category,
       round(sum(sc_att_cr) / 150 + sum(nvl(sc_contact_hrs, 0)) / 450, 2) AS upper_division
  FROM bailey.student_courses a
       LEFT JOIN bailey.courses b
                 ON b.dc_crn = a.dsc_crn AND b.dsc_term_code = a.dsc_term_code
       LEFT JOIN bailey.students03 c
                 ON c.dsc_pidm = a.dsc_pidm AND c.dsc_term_code = a.dsc_term_code
 WHERE a.dsc_term_code IN ('20193E', '20194E', '20202E')
   AND b.c_program_type = 'A'
   AND c_crs_number >= '3000'
   AND c_crs_number < '6000'
   AND c_budget_code LIKE 'B%'
   AND c.s_regent_res IN ('R', 'A', 'M')
 GROUP BY a.dsc_term_code;

/* Lower Division */
SELECT a.dsc_term_code,
       round(sum(sc_att_cr) / 150 + sum(nvl(sc_contact_hrs, 0)) / 450, 2)
  FROM bailey.student_courses a
       LEFT JOIN bailey.courses b
                 ON b.dc_crn = a.dsc_crn AND b.dsc_term_code = a.dsc_term_code
       LEFT JOIN bailey.students03 c
                 ON c.dsc_pidm = a.dsc_pidm AND c.dsc_term_code = a.dsc_term_code
 WHERE a.dsc_term_code = '20202E'
   AND b.c_program_type = 'A'
   AND c_crs_number < '3000'
   AND c_budget_code LIKE 'B%'
   AND c.s_regent_res IN ('R', 'A', 'M')
 GROUP BY a.dsc_term_code;

/* Beginning Graduate */
SELECT nvl(round(sum(sc_att_cr) / 100 + sum(nvl(sc_contact_hrs, 0)) / 450, 2), 0)
  FROM bailey.student_courses a
       LEFT JOIN bailey.courses b
                 ON b.dc_crn = a.dsc_crn AND b.dsc_term_code = a.dsc_term_code
       LEFT JOIN bailey.students03 c
                 ON c.dsc_pidm = a.dsc_pidm AND c.dsc_term_code = a.dsc_term_code
 WHERE a.dsc_term_code = '20202E'
   AND c_budget_code LIKE 'B%'
   AND c.s_regent_res IN ('R', 'A', 'M')
   AND c_level = 'G';

