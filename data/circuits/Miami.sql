BEGIN;

-- add qualif Miami
SELECT new_qualifying(1, 5, 10, false, '2022-05-07', 18);
SELECT new_qualifying(2, 5, 3, false, '2022-05-07', 11);
SELECT new_qualifying(3, 5, 1, false, '2022-05-07', 5);
SELECT new_qualifying(4, 5, 2, false, '2022-05-07', 7);
SELECT new_qualifying(5, 5, 8, false, '2022-05-07', 6);
SELECT new_qualifying(6, 5, 10, false, '2022-05-07', 19);
SELECT new_qualifying(7, 5, 5, true, '2022-05-07', 1);
SELECT new_qualifying(8, 5, 6, false, '2022-05-07', 16);
SELECT new_qualifying(9, 5, 7, false, '2022-05-07', 8);
SELECT new_qualifying(10, 5, 3, false, '2022-05-07', 20);
SELECT new_qualifying(11, 5, 9, false, '2022-05-07', 4);
SELECT new_qualifying(12, 5, 7, false, '2022-05-07', 14);
SELECT new_qualifying(13, 5, 8, false, '2022-05-07', 12);
SELECT new_qualifying(14, 5, 5, false, '2022-05-07', 2);
SELECT new_qualifying(15, 5, 6, false, '2022-05-07', 15);
SELECT new_qualifying(16, 5, 4, false, '2022-05-07', 10);
SELECT new_qualifying(17, 5, 2, false, '2022-05-07', 9);
SELECT new_qualifying(18, 5, 9, false, '2022-05-07', 3);
SELECT new_qualifying(19, 5, 4, false, '2022-05-07', 13);
SELECT new_qualifying(20, 5, 1, false, '2022-05-07', 17);

-- add race Miami
SELECT new_race(1, 5, 10, false, '2022-05-08', 9);
SELECT new_race(2, 5, 3, false, '2022-05-08', 11);
SELECT new_race(3, 5, 1, false, '2022-05-08', 7);
SELECT new_race(4, 5, 2, false, '2022-05-08', 18);
SELECT new_race(5, 5, 8, false, '2022-05-08', 6);
SELECT new_race(6, 5, 10, false, '2022-05-08', 14);
SELECT new_race(7, 5, 5, false, '2022-05-08', 2);
SELECT new_race(8, 5, 6, false, '2022-05-08', 16);
SELECT new_race(9, 5, 7, false, '2022-05-08', 19);
SELECT new_race(10, 5, 3, false, '2022-05-08', 8);
SELECT new_race(11, 5, 9, false, '2022-05-08', 4);
SELECT new_race(12, 5, 7, false, '2022-05-08', 13);
SELECT new_race(13, 5, 8, false, '2022-05-08', 5);
SELECT new_race(14, 5, 5, false, '2022-05-08', 3);
SELECT new_race(15, 5, 6, false, '2022-05-08', 15);
SELECT new_race(16, 5, 4, false, '2022-05-08', 10);
SELECT new_race(17, 5, 2, false, '2022-05-08', 12);
SELECT new_race(18, 5, 9, true, '2022-05-08', 1);
SELECT new_race(19, 5, 4, false, '2022-05-08', 17);
SELECT new_race(20, 5, 1, false, '2022-05-08', 20);

COMMIT;