echo "Build Swift Demo"
cd mapper
swift build -c release
cd ../reducer
swift build -c release
cd ../
echo "Run Demo"
cat testdata.txt | ./mapper/.build/release/mapper | sort | ./reducer/.build/release/reducer
echo "Cleanup"
cd mapper
swift build --clean=dist
cd ../reducer
swift build --clean=dist
cd ../
