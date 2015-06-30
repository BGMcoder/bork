;BROKEN INCLUDES

;#include c:\arx\ahk
;#include core.ahk



#SingleInstance,Force


m(flan:=ProtectData("Only I know :)"))
m(decodedata(flan))

ProtectData(Text,enc="CP0"){
	VarSetCapacity(Data,Len:=StrPut(Text,enc),0),StrPut(Text,&Data,enc),VarSetCapacity(Blob,8,0),VarSetCapacity(Blob_Out,8,0),NumPut(Len,Blob,0,"UInt"),NumPut(&Data,Blob,4,"UPtr"),DllCall("Crypt32.dll\CryptProtectData","UPtr",&Blob,"UPtr",0,"UPtr",0,"UPtr",0,"UPtr",0,"UInt",0,"UPtr",&Blob_Out),Len:=NumGet(Blob_Out,0,"UInt"),Ptr:=NumGet(Blob_Out,4,"UPtr"),DllCall("Crypt32.dll\CryptBinaryToString","ptr",ptr,"uint",len,"uint",0x40000001,"int",0,"uint*",cp),VarSetCapacity(str,cp*(A_IsUnicode?2:1)),DllCall("Crypt32.dll\CryptBinaryToString","ptr",ptr,"uint",len,"uint",0x40000001,ptr,&str,"uint*",cp)
	return StrGet(&str)
}
DecodeData(text,enc="CP0"){
	DllCall("Crypt32.dll\CryptStringToBinary","ptr",&text,"uint",StrLen(text),"uint",1,"ptr",0,"uint*",cp:=0,"ptr",0,"ptr",0),VarSetCapacity(bin,cp),DllCall("Crypt32.dll\CryptStringToBinary","ptr",&text,"uint",StrLen(text),"uint",1,"ptr",&bin,"uint*",cp,"ptr",0,"ptr",0),VarSetCapacity(Blob,4+A_PtrSize,0),VarSetCapacity(Blob_Out,4+A_PtrSize,0),NumPut(cp,Blob,0,"UInt"),NumPut(&bin,Blob,4,"UPtr"),Result:=DllCall("Crypt32.dll\CryptUnprotectData","UPtr",&Blob,"UPtr",0,"UPtr",0,"UPtr",0,"UPtr",0,"UInt",0,"UPtr",&Blob_Out)
	return StrGet(NumGet(Blob_Out,4,"UPtr"),NumGet(Blob_Out,0,"UInt"),enc)
}
m(x*){
	for a,b in x
		list.=b "`n"
	MsgBox,,AHK Studio,% list
}