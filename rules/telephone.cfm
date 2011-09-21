<cfparam name="arguments.telephone" type="string" default="phoneExt">
<cfparam name="arguments.divider" type="string" default="-">

<cfif arguments.autoFix>
	<cfset arguments.value = phoneFormat( arguments.value )>
</cfif>

<cfswitch expression="#arguments.telephone#">

	<cfcase value="phoneStrict7">
		<cfif arguments.autoFix>
			<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9|#arguments.divider#]", "", "all" )>
		</cfif>
		<cfif NOT reFindNoCase( "^[0-9]{3}#arguments.divider#[0-9]{4}$", arguments.value )>
			<cfif arguments.mutable AND NOT arguments.autoFix>
				<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9|#arguments.divider#]", "", "all" )>
			</cfif>
			<cfset arguments.message = "must be formatted similar to: 123#arguments.divider#4567">
		</cfif>
	</cfcase>
	
	<cfcase value="phoneStrict10">
		<cfif arguments.autoFix>
			<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9|#arguments.divider#]", "", "all" )>
		</cfif>
		<cfif NOT reFindNoCase( "^[0-9]{3}#arguments.divider#[0-9]{3}#arguments.divider#[0-9]{4}$", arguments.value )>
			<cfif arguments.mutable AND NOT arguments.autoFix>
				<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9|#arguments.divider#]", "", "all" )>
			</cfif>
			<cfset arguments.message = "must be formatted similar to: 123#arguments.divider#456#arguments.divider#7890">
		</cfif>
	</cfcase>
	
	<cfcase value="phone">
		<cfif arguments.autoFix>
			<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9|#arguments.divider#]", "", "all" )>
		</cfif>
		<cfif NOT reFindNoCase( "^[0-9|#arguments.divider#]{7,12}$", arguments.value )>
			<cfif arguments.mutable AND NOT arguments.autoFix>
				<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9|#arguments.divider#]", "", "all" )>
			</cfif>
			<cfset arguments.message = "must be between 7 and 12 numbers long">
		</cfif>
	</cfcase>
	
	<cfcase value="phoneExt">
		<cfif arguments.autoFix>
			<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9| x#arguments.divider#]", "", "all" )>
		</cfif>
		<cfif NOT reFindNoCase( "^[0-9]{3}#arguments.divider#[0-9]{3}#arguments.divider#[0-9]{4}( x[0-9]{1,6})?$", arguments.value )>
			<cfif arguments.mutable AND NOT arguments.autoFix>
				<cfset arguments.value = reReplaceNoCase( arguments.value, "[^0-9| x#arguments.divider#]", "", "all" )>
			</cfif>
			<cfset arguments.message = "must be entered like: 123#arguments.divider#456#arguments.divider#7890 or 123#arguments.divider#456#arguments.divider#7890 x12345">
		</cfif>
	</cfcase>
	
</cfswitch>


<cffunction name="phoneFormat" output="false" returnType="string">
	<cfargument name="sPhoneNumber" type="string" required="true">
	<cfargument name="sDefaultValue" type="string" default="">
	
	<cfset var sExt = "">
	<cfset var sOutput = sPhoneNumber>
	
	<!--- Replace all non-numeric characters from the string --->
	<cfif listLen( sOutput, "ext" ) GT 1>
		<cfset sExt = reReplace( listLast( sOutput, "ext" ), "[^0-9]", "", "all" )>
		<cfset sOutput = listFirst( sOutput, "ext" )>
	</cfif>
	<cfset sOutput = reReplaceNoCase( sOutput, "[^0-9]", "", "all" )>
	
	<cfswitch expression="#len( sOutput )#">
		<cfcase value="7"><!--- XXX-XXXX --->
			<cfset sOutput = left( sOutput, 3 ) & "-" & right( sOutput, 4 )>
		</cfcase>
		<cfcase value="10"><!--- XXX-XXX-XXXX --->
			<cfset sOutput = left( sOutput, 3 ) & "-" & mid( sOutput, 4, 3 ) & "-" & right( sOutput, 4 )>
		</cfcase>
		<!--- <cfcase value="10"><!--- (XXX) XXX-XXXX --->
			<cfset sOutput = "(" & left( sOutput, 3 ) & ") " & mid( sOutput, 4, 3 ) & "-" & right( sOutput, 4 )>
		</cfcase> --->
		<cfcase value="11"><!--- X-XXX-XXX-XXXX --->
			<cfset sOutput = left( sOutput, 1 ) & "-" & mid( sOutput, 2, 3 ) & "-" & mid( sOutput, 5, 3 ) & "-" & right( sOutput, 4 )>
		</cfcase>
		<cfdefaultcase><!--- return a default value instead --->
			<cfif len( sDefaultValue )>
				<cfset sOutput = sDefaultValue>
			<cfelse>
				<cfset sOutput = sPhoneNumber>
			</cfif>
		</cfdefaultcase>
	</cfswitch>
	
	<cfif len( sExt )>
		<cfset sOutput = sOutput & " x" & sExt>
	</cfif>
	
	<cfreturn sOutput>
</cffunction>