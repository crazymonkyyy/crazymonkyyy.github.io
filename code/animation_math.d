	foreach(t;20..245){
		discmphigh=t;
		discmplow=t*1.66-200;
		discmp2high=(t-85)/2;
		discmp2low=((t-200.0)/2)*2.5;
		if(t>225){
			discmphigh=t-225.0;
			discmplow=-100;
		}
		...