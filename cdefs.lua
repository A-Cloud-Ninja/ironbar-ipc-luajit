local ffi = require("ffi")
ffi.cdef[[
struct sockaddr {
	unsigned short sa_family;
	char sa_data[14];
};
struct in_addr {
	unsigned long s_addr;
};
struct sockaddr_in {
	short int sin_family;
	unsigned short int sin_port;
	struct in_addr sin_addr;
	unsigned char sin_zero[8];
};
struct sockaddr_un {
	unsigned short sun_family;
	char sun_path[108];
};
typedef unsigned int socklen_t;
]]
ffi.cdef[[
int socket(int domain, int type, int protocol);
int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
int close(int fd);
unsigned int sleep(unsigned int seconds);
]]
ffi.cdef[[
int write(int fd, const void *buf, unsigned int count);
int read(int fd, void *buf, unsigned int count);
]]
return ffi
