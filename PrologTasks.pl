
/*Extra KnowledgeBase for Task four*/
:-['students_courses.pl'].
number(nine,9).
number(eight,8).
number(eleven,7).
number(six,6).
number(five,5).
number(four,4).
number(three,3).
number(two,2).
number(one,1).
number(zero,0).



%Task1
studentsInCourse(Course,List):-
    getSG(Course,[],List),!.
    


getSG(Course,Tmplist,List):-
    student(Stud,Course,G),
    not(mem([Stud,G],Tmplist)),!,
    appe(Tmplist,[[Stud,G]],NewTmplist),
    getSG(Course,NewTmplist,List).



getSG(_,List,List).
    

%Task2
numStudents(Course,Ans):-
	getAllStudents(Course,[],List),
	getLength(List,0,Ans),
	!.
	

getAllStudents(Course,Tmplist,List):-
	student(Stud,Course,_),
	not(mem(Stud,Tmplist)),!,
	appe(Tmplist,[Stud],NewTmplist),
	getAllStudents(Course,NewTmplist,List).

getAllStudents(_,List,List).
	
	
getLength([],Cnt,Cnt).

getLength([_|T],Cnt,Ans):-
	NewCnt is Cnt+1,
	getLength(T,NewCnt,Ans).

%Task3


maxStudentGrade(Stud,MaxGrade):-
	getAllGrades(Stud,[],List),
	getMaxGrade(List,0,MaxGrade),!.



getAllGrades(Stud,Tmplist,List):-
	student(Stud,_,G),
	not(mem(G,Tmplist)),!,
	appe(Tmplist,[G],NewTmplist),
	getAllGrades(Stud,NewTmplist,List).



getAllGrades(_,List,List).
	
	
	
getMaxGrade([],Grade,Grade).


getMaxGrade([H|T],Grade,Ans):-
	H>Grade,
	NewGrade is H,
	getMaxGrade(T,NewGrade,Ans).

getMaxGrade([H|T],Grade,Ans):-
	H=<Grade,
	getMaxGrade(T,Grade,Ans).


%Task4
gradeInWords(Stud, Course, Res):-
	student(Stud, Course, DigitsWords),
	digitsList(DigitsWords,[],List),
	wordGrade(List, [],Res),!.
	

digitsList(0,List,List):-
!.
		
digitsList(DigitsWords,Tmplist,List):-
	TempRes is DigitsWords - (10 * (DigitsWords//10)),
	appe([TempRes],Tmplist,NewTmplist),
	NewDigitsWords is DigitsWords//10,
	digitsList(NewDigitsWords,NewTmplist,List).


wordGrade([], Res,Res).
wordGrade([H|T],TmpList,Res):-
	number(X,H),
	appe(TmpList,[X], NewTmpList),
	wordGrade(T,NewTmpList,Res).

        
remainingCourses(Stud, Course, Courses):-
	getallprerequest(Course,[],Courses1),
	getCoursesAndGrades(Stud, [], [], CoursesList, GradesList),
	getAllSGN(CoursesList, GradesList, Courses1 ,[],Courses2),
	not(check(Courses2)),!,
	subList(Courses1, Courses2, Courses),!.

getallprerequest([],List,List):-!.
getallprerequest(Course,List,Ans):-
	prerequisite(X,Course),!,
	appe([X],List,NewtmpList),
	getallprerequest(X,NewtmpList,Ans).
getallprerequest(_,List,Ans):-
	getallprerequest([],List,Ans).

getCoursesAndGrades(Stud, TmpCourses, TmpGrades, CoursesList, GradesList):-
	student(Stud,C,G),
	not(mem(C,TmpCourses)),!,
	appe([C],TmpCourses,NewTmpCourses),
	appe([G],TmpGrades,NewTmpGrades),
	getCoursesAndGrades(Stud, NewTmpCourses,NewTmpGrades,CoursesList,GradesList).

getCoursesAndGrades(_,TmpCourses,TmpGrades,TmpCourses,TmpGrades).


getAllSGN([CoursesHead|CoursesTail],[GradesHead|GradesTail], PreCourseslist,TmplistC,CourseList):-
	not(mem(CoursesHead,TmplistC)),!,
	memberCheck(CoursesHead, GradesHead, PreCourseslist,ElementToAppend),
	appe(ElementToAppend,TmplistC,NewTmplistC),
	getAllSGN(CoursesTail, GradesTail,PreCourseslist,NewTmplistC,CourseList).
		
getAllSGN(_, _,_,CourseList,CourseList).

memberCheck(C, G, PreCourseslist, [C]):-
	mem(C,PreCourseslist),
	G >= 50.
memberCheck(_,_,_,[]).


subList([], _, []).
subList([H|T], SecondList, ThirdList) :-
        memberchk(H, SecondList),
        !,
        subList(T, SecondList, ThirdList).
subList([H|T1], SecondList, [H|T3]) :-
        subList(T1, SecondList, T3).
	
check([]).


%MemberFunctions
mem(Ele,[Ele|_]).
mem(Ele,[_|T]):-
    mem(Ele,T).
appe([],End,End).
appe([H|T],SecondList, [H|T2]):-
    appe(T,SecondList,T2).
