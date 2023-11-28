CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

testfile=`find student-submission -name "ListExamples.java"`
if [[ -f $testfile ]]
then
    echo "Correct filename. Continuing grading procedure."
else 
    echo "Error: No ListExamples file. Try renaming submission file to ListExamples."
    exit
fi


if [[ -r $testfile ]]
then
    cp $testfile grading-area
else
    echo "Error: file unreadable"
    quit
fi

cp $testfile .
javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java
if [ $? -eq 0 ]
then
    echo "No compilation error, running tests"
else
    echo "Compliation failed."
    exit
fi
java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > Test-results.txt

#grep "failure" Test-results.txt
grep  'Failures' Test-results.txt > final-line.txt

wc -l < final-line.txt
if [[ `wc -l < final-line.txt` -eq 0 ]]
then
    echo "passed"
else
    echo "failed"
fi
cat final-line.txt

# java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples.java
# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
