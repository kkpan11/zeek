# Test windows linebreaks

# @TEST-EXEC: btest-bg-run zeek zeek -b %INPUT
# @TEST-EXEC: btest-bg-wait 10
# @TEST-EXEC: btest-diff out

redef exit_only_after_terminate = T;

# @TEST-START-FILE input.log
#separator \x09
#path	ssh
#fields	b	i	e	c	p	sn	a	d	t	iv	s	sc	ss	se	vc	ve	ns
#types	bool	int	enum	count	port	subnet	addr	double	time	interval	string	table	table	table	vector	vector	string
T	-42	SSH::LOG	21	123	10.0.0.0/24	1.2.3.4	3.14	1315801931.273616	100.000000	hurz	2,4,1,3	CC,AA,BB	EMPTY	10,20,30	EMPTY	4242
# @TEST-END-FILE

@load base/protocols/ssh

global outfile: file;

redef InputAscii::empty_field = "EMPTY";

module A;

type Idx: record {
	i: int;
};

type Val: record {
	b: bool;
	e: Log::ID;
	c: count;
	p: port;
	sn: subnet;
	a: addr;
	d: double;
	t: time;
	iv: interval;
	s: string;
	ns: string;
	sc: set[count];
	ss: set[string];
	se: set[string];
	vc: vector of int;
	ve: vector of int;
};

global servers: table[int] of Val = table();

event zeek_init()
	{
	outfile = open("../out");
	# first read in the old stuff into the table...
	Input::add_table([$source="../input.log", $name="ssh", $idx=Idx, $val=Val, $destination=servers]);
	}

event Input::end_of_data(name: string, source:string)
	{
	print outfile, servers;
	print outfile, to_count(servers[-42]$ns); # try to actually use a string. If null-termination is wrong this will fail.
	Input::remove("ssh");
	close(outfile);
	terminate();
	}
