<cfparam name="arguments.stateList" type="string" default="AL,AK,AZ,AR,CA,CO,CT,DE,FL,GA,HI,ID,IL,IN,IA,KS,KY,LA,ME,MD,MA,MI,MN,MS,MO,MT,NE,NV,NH,NJ,NM,NY,NC,ND,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VT,VA,WA,DC,WV,WI,WY,AA,AE,AP,AS,FM,GU,MH,MP,PR,PW,VI">
<cfparam name="arguments.provinceList" type="string" default="AB,BC,MB,NB,NF,NT,NS,NU,PE,QC,SK,YK,ON">

<cfif NOT listFindNoCase( arguments.stateList, arguments.value ) AND NOT listFindNoCase( arguments.provinceList, arguments.value )>
	<cfset arguments.value = "">
	<cfset arguments.message = "is not a valid state or province">
</cfif>


