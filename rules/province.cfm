<cfparam name="arguments.provinceList" type="string" default="AB,BC,MB,NB,NF,NT,NS,NU,PE,QC,SK,YK,ON">

<cfif NOT listFindNoCase( arguments.provinceList, arguments.value )>
	<cfset arguments.value = "">
	<cfset arguments.message = "is not a valid province">
</cfif>
