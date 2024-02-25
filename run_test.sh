rm src/compiler_ram_spike/*.class
rm output.log
rm hotspot_*.log

javac src/compiler_ram_spike/*.java #-XDstringConcat=inline

java -classpath src \
        -XX:+UnlockDiagnosticVMOptions \
        -XX:+LogCompilation \
        -XX:+PrintCompilation \
        -XX:NativeMemoryTracking=summary \
        compiler_ram_spike.RunTest > output.log &
JAVA_PID=$!
jcmd $JAVA_PID VM.native_memory baseline
watch -n 1 jcmd $JAVA_PID VM.native_memory summary.diff
