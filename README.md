Call home and establish reverse proxy for SSH access behind NAT/firewall. 

## Usage
- [optional] generate your own host keys, or they will get auto-generated on build  

1. [required] use an existing rsa/dsa keypair or generate a new one and copy public  
   key to `./authorized_keys`
2. build container with `docker build -t callhome .`
3. launch container, making sure docker-forwarded port will be accessible
4. check/edit `callhome.sh` for customization with ENV variables
5. run `callhome.sh`
6. don't blame me if you get hacked
