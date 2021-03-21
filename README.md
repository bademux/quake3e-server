# Build
```bash docker build . -t bademux/q3e-server```

# Run
```bash 
docker run -it \
 -v "$(readlink -f "/home/$USER/.q3a/baseq3")":/home/user/baseq3 \
 -v "$(pwd)/server.cfg":/home/user/baseq3/q3config_server.cfg \
 -p 27960:27960/udp \
 bademux/q3e-server "+map q3dm17"
```

type ```quit``` to exit server
