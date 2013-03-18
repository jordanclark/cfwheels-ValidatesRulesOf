<cfparam name="arguments.range" type="string">
<cfparam name="arguments.rangeType" type="string" default="number">

<cfset arguments.rangeStart = listGetAt( arguments.range, 1, "-" )>
<cfset arguments.rangeEnd = listGetAt( arguments.range, 2, "-" )>

<!--- reverse the ranges if they are of opposite values --->
<cfif arguments.rangeStart GT arguments.rangeEnd>
	<cfset arguments.rangeTmp = arguments.rangeStart>
	<cfset arguments.rangeStart = arguments.rangeEnd>
	<cfset arguments.rangeEnd = arguments.rangeTmp>
</cfif>

<!--- require one or the other attribute --->
<cfif arguments.value LT arguments.rangeStart OR arguments.value GT arguments.rangeEnd>
	<cfswitch expression="#arguments.rangeType#">
		<cfcase value="dollar,dollars">
			<cfset arguments.message = "must be within the range of #dollarFormat( arguments.rangeStart )# to #dollarFormat( arguments.rangeEnd )#">
		</cfcase>
		<cfcase value="decimal">
			<cfset arguments.message = "must be within the range of #decimalFormat( arguments.rangeStart )# to #decimalFormat( arguments.rangeEnd )#">
		</cfcase>
		<cfcase value="number,numbers">
			<cfset arguments.message = "must be within the range of #numberFormat( arguments.rangeStart )# to #numberFormat( arguments.rangeEnd )#">
		</cfcase>
		<cfcase value="year,years">
			<cfset arguments.message = "must be within the years #arguments.rangeStart# to #arguments.rangeEnd#">
		</cfcase>
		<cfdefaultcase>
			<cfset arguments.message = "must be within #arguments.rangeStart# #arguments.rangeType# to #arguments.rangeEnd# #arguments.rangeType#">
		</cfdefaultcase>
	</cfswitch>
</cfif>

