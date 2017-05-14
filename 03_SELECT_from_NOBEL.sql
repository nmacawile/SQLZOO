/* 1
Show Nobel prizes for 1950.
*/

SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;

/* 2
Show who won the 1962 prize for Literature.
*/

SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature';

/* 3
Show the year and subject that won 'Albert Einstein' his prize.
*/

SELECT yr, subject
  FROM nobel
 WHERE winner = 'Albert Einstein';

/* 4
Give the name of the 'Peace' winners since the year 2000, including 2000.
*/

SELECT winner
  FROM nobel
 WHERE subject = 'Peace'
   AND yr >= 2000;

/* 5
Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.
*/

SELECT yr, subject, winner
  FROM nobel
 WHERE subject = 'Literature'
   AND yr BETWEEN 1980 AND 1989;

/* 6
Show all details of the presidential winners:
Theodore Roosevelt
Woodrow Wilson
Jimmy Carter
Barack Obama
*/

SELECT *
  FROM nobel
 WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');

/* 7
Show the winners with first name John.
*/

SELECT winner
  FROM nobel
 WHERE winner LIKE 'John %';

/* 8
Show (all details of) the Physics winners for 1980 together with the Chemistry winners for 1984.
*/

SELECT *
  FROM nobel
 WHERE (subject = 'Physics'
   AND yr = 1980)
    OR (subject = 'Chemistry'
   AND yr = 1984);

/* 9
Show (all details of) the winners for 1980 excluding the Chemistry and Medicine
*/

SELECT *
  FROM nobel
 WHERE yr = 1980
   AND subject NOT IN ('Chemistry', 'Medicine');

/* 10
Show who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004).
*/

SELECT *
  FROM nobel
 WHERE (subject = 'Medicine'
   AND yr < 1910)
    OR (subject = 'Literature' 
   AND yr >= 2004);

/* 11
Find all details of the prize won by PETER GRÜNBERG.
*/

/* using unicode character */
SELECT *
  FROM nobel
 WHERE winner = 'Peter Grünberg';

/* using wildcard (might match other entries, unlikely in this case) */
SELECT *
  FROM nobel
 WHERE winner LIKE 'Peter Gr_nberg';

/* 12
Find all details of the prize won by EUGENE O'NEILL.
*/

SELECT *
  FROM nobel
 WHERE winner = 'Eugene O\'Neill';

/* 13
List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
*/

SELECT winner, yr, subject
  FROM nobel
 WHERE winner LIKE 'Sir %'
 ORDER BY yr DESC, winner ASC;

/* 14
The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.

Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
*/

/* with subquery */
SELECT winner, subject
  FROM (SELECT winner, subject,
               subject IN ('Physics','Chemistry') AS specialsubjects
          FROM nobel
         WHERE yr = 1984) subquery
 ORDER BY specialsubjects, subject, winner;

/* original solution */
SELECT winner, subject
  FROM nobel
 WHERE yr = 1984
 ORDER BY CASE WHEN subject IN ('Physics', 'Chemistry') THEN 1 ELSE 0 END,
       subject, winner;