#!/usr/bin/env -S sh -c 'dmd -run gengifedit3.d | convert -size 450x360 -depth 8 rgb:- output.gif'
enum width=450;
enum height=360;
import std;
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
int time;
struct data{
	ubyte color;
	int x;
	void write(){
		if(time-3<x&& time+3>x){
			int c=time-x+8;
			if(color==0){
				c%=8;
			} else {
				c+=color;
				c%=8;
				c+=8;
			}
			stdout.rawWrite(colors[c]);
		}else{
			stdout.rawWrite(colors[color]);
	}}
}
auto lerp(T)(T startValue, T endValue, float t){
	return startValue + (endValue - startValue) * t;
}
data[height][width] data_;
void main(){
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
			ubyte o=0;
			if(t<22||y<2){
				o=7;
			} else {
			if(t%50==0 &&(y/5)%3==0){
				o=7;
			} else {
			if(y%50==0 &&(t/5)%3==0){
				o=7;
			} else {
			if(y<discmphigh &&y>discmplow){
				o=8;
			}
			if(y<discmp2high &&y>discmp2low){
				o=9;
			}
			}}}
			data_[(t-20)*2+1][y].color=o;
			data_[(t-20)*2+0][y].color=o;
			data_[(t-20)*2+0][y].x=(t-20)*2;
			data_[(t-20)*2+1][y].x=(t-20)*2+1;
			
		}
	}
	foreach(t;0..width){
		time=t;
	foreach(y;0..height){
	foreach(x;0..width){
		if(x==t){
			stdout.rawWrite(colors[15]);
		} else {
			data_[x][height-y-1].write;
		}
		//data_[x][height-y-1].write;
	}}}
}