#!/usr/bin/env -S sh -c 'dmd -run gengif.d | convert -size 840x360 -depth 8 rgb:- output.gif'
enum width=840;
enum height=360;
import std;
struct colorpoint{
	ubyte color;
	short x;
	short y;
}
auto points=[
colorpoint(0,30,30),
colorpoint(0,30,134),
colorpoint(1,82,134),
colorpoint(1,82,30),
colorpoint(1,82,290),
colorpoint(1,82,82),
colorpoint(13,706,30),
colorpoint(13,706,186),
colorpoint(12,758,30),
colorpoint(2,134,30),
colorpoint(2,134,134),
colorpoint(2,134,82),
colorpoint(3,186,30),
colorpoint(3,186,186),
colorpoint(3,186,134),
colorpoint(3,186,238),
colorpoint(14,654,290),
colorpoint(14,654,30),
colorpoint(4,238,82),
colorpoint(4,238,30),
colorpoint(4,238,238),
colorpoint(11,810,30),
colorpoint(5,290,30),
colorpoint(5,290,290),
colorpoint(5,290,186),
colorpoint(5,290,82),
colorpoint(5,290,238),
colorpoint(10,446,134),
colorpoint(10,446,30),
colorpoint(9,498,30),
colorpoint(9,498,238),
colorpoint(15,602,290),
colorpoint(15,602,30),
colorpoint(8,550,30),
colorpoint(8,550,82),
colorpoint(6,342,30),
colorpoint(6,342,290),
colorpoint(6,342,186),
colorpoint(6,342,238),
colorpoint(7,394,30),
colorpoint(7,394,186),
];
struct color(){
	ubyte[3] a;
}
auto colors=[
cast(ubyte[3])([0, 43, 54]),
cast(ubyte[3])([7, 54, 66]),
cast(ubyte[3])([88, 110, 117]),
cast(ubyte[3])([101, 123, 131]),
cast(ubyte[3])([131, 148, 150]),
cast(ubyte[3])([147, 161, 161]),
cast(ubyte[3])([238, 232, 213]),
cast(ubyte[3])([253, 246, 227]),
cast(ubyte[3])([220, 50, 47]),
cast(ubyte[3])([203, 75, 22]),
cast(ubyte[3])([181, 137, 0]),
cast(ubyte[3])([133, 153, 0]),
cast(ubyte[3])([42, 161, 152]),
cast(ubyte[3])([38, 139, 210]),
cast(ubyte[3])([108, 113, 196]),
cast(ubyte[3])([211, 54, 130]),
];
auto distance(int x1, int y1, int x2, int y2) {
    int dx = x2 - x1;
    int dy = y2 - y1;
    return sqrt(cast(float)dx * dx + dy * dy);
}
float discmphigh;
float discmplow;
float discmp2high;
float discmp2low;
struct data{
	ubyte color;
	float dis;
	ubyte color2;
	float dis2;
	void write(){
		if(dis2<discmp2high && dis2>discmp2low){
			//stdout.rawWrite(cast(ubyte[3])[color2*15,color2*15,color2*15]);
			stdout.rawWrite(colors[color2]);
			return;
		}
		if(dis<discmphigh && dis>discmplow){
			if(color==0 && (discmphigh-dis<6||dis-discmplow<6)){
				//stdout.rawWrite(cast(ubyte[3])[15,15,15]);
				stdout.rawWrite(colors[1]);
			} else {
			//stdout.rawWrite(cast(ubyte[3])[color*15,color*15,color*15]);
			stdout.rawWrite(colors[color]);
		}} else {
			//stdout.rawWrite(cast(ubyte[3])[0,0,0]);
			stdout.rawWrite(colors[0]);
		}
	}
}
data[height][width] data_;
void main(){
	foreach(y;0..height){
	foreach(x;0..width){
		ubyte a;
		float dis=cast(float)99999999999;
		foreach(p;points){
			auto d=distance(x,y,p.x,p.y);
			if(d<dis){
				dis=d;
				a=p.color;
		}}
		data_[x][y].dis=cast(ubyte)dis;
		data_[x][y].color=a;
	}}
	foreach(i;0..100000){
		int x=uniform(0,width);
		int y=uniform(0,height);
		int d=uniform(0,50);
		ubyte c=data_[x][y].color;
		foreach(y_;max(0,y-d)..min(height,y+d+1)){
		foreach(x_;max(0,x-d)..min(width,x+d+1)){
			float d_=distance(x,y,x_,y_);
			if(d_<d){
				data_[x_][y_].dis2=cast(short)d_;
				data_[x_][y_].color2=c;
			}
		}}
	}
	foreach(t;20..245){
		discmphigh=t;
		discmplow=t*1.66-200;
		discmp2high=(t-85)/2;
		discmp2low=((t-200.0)/2)*2.5;
		if(t>225){
			discmphigh=t-225.0;
			discmplow=-100;
		}
	foreach(y;0..height){
	foreach(x;0..width){
		data_[x][y].write;
	}}}
}