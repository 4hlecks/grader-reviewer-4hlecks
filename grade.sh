CPATH=".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar"

rm ListExamples*
rm *.class
rm -rf student-submission
rm errorFIle.txt
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission
echo 'In submission directory'

cp ListExamples.java ..
cd ..

if [[ -f ListExamples.java ]]
then
    echo 'ListExamples found'
else
    echo 'Missing File ListExamples.java'
    exit 1
fi

FILTER=`grep -c -i "static List<String> filter(List<String> list, StringChecker sc)" ListExamples.java`
MERGE=`grep -c -i "static List<String> merge(List<String> list1, List<String> list2)" ListExamples.java`

if [[ $FILTER -eq 1 ]]
then
    echo "Filter method found."
else
    echo "Filter method not found."
    exit 1
fi

if [[ $MERGE -eq 1 ]]
then
    echo "Merge method found."
else
    echo "Merge method not found."
    exit 1
fi

if [[ $? -eq 0 ]]
then
    echo "Implementation passed."
else
    echo "Implementation failed"
fi

javac -cp $CPATH *.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > errorFile.txt 2>&1

if grep -q "OK" errorFile.txt
then
    echo "Great job!"
    echo "Grade: 100%"
else
    echo `grep -e "failure" errorFile.txt`
fi