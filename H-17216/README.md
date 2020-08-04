Ubuntu 18.04

https://docs.docker.com/engine/install/ubuntu/

Launch a standalone mongod process in a container.
```
sudo sysctl -w kernel.perf_event_paranoid=-1
sudo sysctl -w kernel.kptr_restrict=0
sudo docker build . -t josef
sudo docker run -d --cap-add SYS_ADMIN -ti josef
```

perf record the container (`docker ps` to get the container name, pensive_banach in this example).
```
# all processes
sudo docker container exec pensive_banach perf record -a -g -o perf.data -- sleep 3

# mongod only
sudo docker container exec pensive_banach perf record -a -g -p 1 -o perf.data -- sleep 3

sudo docker container exec pensive_banach perf script > perf.data.scripted
```

Attach to the container via bash.
```
sudo docker container exec -it pensive_banach bash
```
