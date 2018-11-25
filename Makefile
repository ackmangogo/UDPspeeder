CXXFLAGS += -std=c++11 -Wall -Wextra -Wno-unused-variable -Wno-unused-parameter -Wno-missing-field-initializers
GPP := g++

all: speederv2

%.o: %.cpp Makefile
	@echo "  CPP $@"
	@$(GPP) $(CFLAGS) -c -o $@ $< -Os -Wno-unused-result -I. -isystem libev

speederv2: main.o log.o common.o lib/fec.o lib/rs.o packet.o delay_manager.o fd_manager.o connection.o fec_manager.o misc.o tunnel_client.o tunnel_server.o my_ev.o
	@echo "  LD  $@"
	@$(GPP) $(LDFLAGS) -o $@ $^

install: speederv2
	mkdir -p $(ROOT)/usr/bin
	install -m755 speederv2 $(ROOT)/usr/bin/speederv2

clean:
	rm -f speederv2 {main,log,common,lib/fec,lib/rs,packet,delay_manager,fd_manager,connection,fec_manager,misc,tunnel_client,tunnel_server,my_ev}.o
