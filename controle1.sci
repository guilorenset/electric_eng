function [G]=tf(x, y)
	inv = flipdim(x, 2)
		num = poly (inv, 's', 'c')
	inv = flipdim(y, 2)
		den = poly( inv, 's', 'c')
	
	G=syslin('c', num, den)
endfunction


function [x]=dcgain(G)
	D=tf2ss(G)
	
	x=D(5)-(D(4)/D(2))*D(3)
endfunction

function [x]=pole(G)
	[a,b,c]=tf2zp(G)
	
	x=b
endfunction

function step(x, varargin)

	if isempty(varargin) then
		t_final=15
	else
		t_final=varargin(1)
	end
	t=0:0.01:t_final; 
	plot2d(t,csim('step',t,G))
	xlabel("Tempo (s)")
	ylabel("Amplitude")

endfunction
