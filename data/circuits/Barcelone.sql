BEGIN;
SELECT new_qualifying(1, 6, 10, false, '2022-05-21', 19);
SELECT new_qualifying(2, 6, 3, false, '2022-05-21', 17);
SELECT new_qualifying(3, 6, 1, false, '2022-05-21', 7);
SELECT new_qualifying(4, 6, 2, false, '2022-05-21', 14);
SELECT new_qualifying(5, 6, 8, false, '2022-05-21', 6);
SELECT new_qualifying(6, 6, 10, false, '2022-05-21', 20);
SELECT new_qualifying(7, 6, 5, true, '2022-05-21', 1);
SELECT new_qualifying(8, 6, 6, false, '2022-05-21', 8);
SELECT new_qualifying(9, 6, 7, false, '2022-05-21', 11);
SELECT new_qualifying(10, 6, 3, false, '2022-05-21', 12);
SELECT new_qualifying(11, 6, 9, false, '2022-05-21', 5);
SELECT new_qualifying(12, 6, 7, false, '2022-05-21', 9);
SELECT new_qualifying(13, 6, 8, false, '2022-05-21', 4);
SELECT new_qualifying(14, 6, 5, false, '2022-05-21', 3);
SELECT new_qualifying(15, 6, 6, false, '2022-05-21', 10);
SELECT new_qualifying(16, 6, 4, false, '2022-05-21', 18);
SELECT new_qualifying(17, 6, 2, false, '2022-05-21', 13);
SELECT new_qualifying(18, 6, 9, false, '2022-05-21', 2);
SELECT new_qualifying(19, 6, 4, false, '2022-05-21', 16);
SELECT new_qualifying(20, 6, 1, false, '2022-05-21', 15);
SELECT new_race(1, 6, 10, false, '2022-05-22', 18);
SELECT new_race(2, 6, 3, false, '2022-05-22', 9);
SELECT new_race(3, 6, 1, false, '2022-05-22', 6);
SELECT new_race(4, 6, 2, false, '2022-05-22', 13);
SELECT new_race(5, 6, 8, false, '2022-05-22', 5);
SELECT new_race(6, 6, 10, false, '2022-05-22', 16);
SELECT new_race(7, 6, 5, false, '2022-05-22', 20);
SELECT new_race(8, 6, 6, false, '2022-05-22', 17);
SELECT new_race(9, 6, 7, false, '2022-05-22', 8);
SELECT new_race(10, 6, 3, false, '2022-05-22', 7);
SELECT new_race(11, 6, 9, true, '2022-05-22', 2);
SELECT new_race(12, 6, 7, false, '2022-05-22', 12);
SELECT new_race(13, 6, 8, false, '2022-05-22', 3);
SELECT new_race(14, 6, 5, false, '2022-05-22', 4);
SELECT new_race(15, 6, 6, false, '2022-05-22', 14);
SELECT new_race(16, 6, 4, false, '2022-05-22', 15);
SELECT new_race(17, 6, 2, false, '2022-05-22', 10);
SELECT new_race(18, 6, 9, false, '2022-05-22', 1);
SELECT new_race(19, 6, 4, false, '2022-05-22', 11);
SELECT new_race(20, 6, 1, false, '2022-05-22', 19);
COMMIT;