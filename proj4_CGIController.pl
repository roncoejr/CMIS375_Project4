#!/usr/local/bin/perl --

#
#
#
# Filename: proj4_CGIController.pl
#
# Description: Project 4 CGI Controller
# By: Ronald Coe, Jr.
# CMIS 375
#
# use Win32::ODBC;
use DBI;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);

###############################################
#
# Initialize variables
#
#
##################
# Get data passed in by the form
$doc_len = $ENV{'CONTENT_LENGTH'};
read(STDIN, $formData, $doc_len);

@formDataArray = split(/&/, $formData);

# Iterate through the varable/value pairs and assign relationships
foreach $var_value (@formDataArray) {
	#
	# Parse the contents of the var_value and separate field from value
	#
	($field_name, $field_value) = split(/=/, $var_value);
	
	#
	# Replace any '+' signs with a space
	#
	$field_value =~ s/\+/ /g;
	
	#
	# Replace any hexidecimal values with human readable alternatives
	#
	$field_value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C",hex($1))/eg;
	
	
	#
	# Find the name of the form used to post the data, or build the FORM hash
	#
	#
	if($field_name eq "frmName") {
		$frmName = $field_value;
	} else {
		$FORM{$field_name} = $field_value;
	}
}


&setContentHeaderHTML;

################################################################################
#
# Depending upon the form used, call the appropriate function
#
#
##########
if ($frmName eq "frmAddGenre") {
	#
	#
	#
	#
	&addGenre(\%FORM);
	#
	#
} elsif ($frmName eq "frmEditGenre") {
	#
	#
	#
	#
	&editGenre(\%FORM);
	#
	#
} elsif ($frmName eq "frmDeleteGenre") {
	#
	#
	#
	#
	&deleteGenre(\%FORM);
	#
	#
} elsif ($frmName eq "frmAddMPARating") {
	#
	#
	#
	#
	&addMPARating(\%FORM);
	#
	#
} elsif ($frmName eq "frmEditMPARating") {
	#
	#
	#
	#
	&editMPARating(\%FORM);
	#
	#
} elsif ($frmName eq "frmDeleteMPARating") {
	#
	#
	#
	#
	&deleteMPARating(\%FORM);
	#
	#
} elsif ($frmName eq "frmAddTitle") {
	#
	#
	#
	#
	&addTitle(\%FORM);
	#
	#
} elsif ($frmName eq "frmEditTitle") {
	#
	#
	#
	#
	&editTitle(\%FORM);
	#
	#
} elsif ($frmName eq "frmDeleteTitle") {
	#
	#
	#
	#
	&deleteTitle(\%FORM);
	#
	#
}

&closeHTML;

################################################################################
#
# Description: Function used to set the Content header for the HTTP response
#
#
##################
sub setContentHeaderHTML {
	# print "HTTP/1.1 200 OK\n";
	# print "Content-Type:text/html\n\n";
	# print "<html>";
	print header;
}

################################################################################
#
# Description: Function used to set the Content header for the HTTP response
#
#
##################
sub setContentHeaderXML {
	# print "HTTP/1.1 200 OK\n";
	print "Content-Type:text/xml\n\n";
	print qq(<html>);
}

################################################################################
#
# Description: Function used to close the HTML document
#
#
##################
sub closeHTML {
	#print qq(</body>);
	#print qq(</html>);
	print end_html;
}

###############################################
#
# Description: Function used to add Genres to the database
#
#
##################
sub addGenre {
	#
	# Get the reference to the form data
	#
	my ($form_data) = @_;
	
	print start_html(-title=>'Add Genre Subroutine');
	print h1("The addGenre subroutine was  called!");
	print qq(The Genre: $$form_data{"fldGenre"} would have been added to the database.);
}

###############################################
#
# Description: Function used to edit Genres in the database
#
#
##################
sub editGenre {
	#
	# Get the reference to the form data
	#
	my ($form_data) = @_;
	print start_html(-title=>'Edit Genre Subroutine');
	print h1("The editGenre subroutine was  called!");
	print qq(The Genre: $$form_data{"fldGenre"} would have been edited in the database.);
}

###############################################
#
# Description: Function used to delete Genres from the database
#
#
##################
sub deleteGenre {
	#
	# Get the reference to the form data
	#
	my ($form_data) = @_;
	print start_html(-title=>'Delete Genre Subroutine');
	print h1("The deleteGenre subroutine was  called!");
	print qq(The Genre: $$form_data{"fldGenre"} would have been deleted from the database.);
}

###############################################
#
# Description: Function used to add MPA Ratings to the database
#
#
##################
sub addMPARating {
	#
	# Get the reference to the form data
	#
	my ($form_data) = @_;
	print start_html(-title=>'Add MPA Rating Subroutine');
	print h1("The addMPARating subroutine was  called!");
	print qq(The MPA Rating: $$form_data{"fldMPARating eq "} would have been added to the database.);
}

###############################################
#
# Description: Function used to edit MPA Ratings in the database
#
#
##################
sub editMPARating {
	#
	# Get the reference to the form data
	#
	my ($form_data) = @_;
	print start_html(-title=>'Edit MPA Rating Subroutine');
	print h1("The editMPARating subroutine was  called!");
	print qq(The MPA Rating: $$form_data{"fldMPARating"} would have been edited in the database.);
}

###############################################
#
# Description: Function used to delete MPA Ratings from the database
#
#
##################
sub deleteMPARating {
	#
	# Get the reference to the form data
	#
	my ($form_data) = @_;
	print start_html(-title=>'Delete MPA Rating Subroutine');
	print h1("The deleteMPARating subroutine was  called!");
	print qq(The MPA Rating: $$form_data{"fldMPARating"} would have been deleted from the database.);
}

###############################################
#
# Description: Function used to add Blu-Ray titles to the database
#
#
##################
sub addTitle {
	#
	# Get the reference to the form data
	#
	my ($form_data) = @_;
	print start_html(-title=>'Add Title Subroutine');
	print h1("The addTitle subroutine was  called!");
	print qq(The Blu-Ray Title: $$form_data{"fldTitle"} would have been added to the database.<br>);
	print qq(<center><table>);
	print qq(<th><td>Other Title Attributes</td></th>);
	print qq(<tr><td>$$form_data{"fldMPARating"}</td></tr>);
	print qq(<tr><td>$$form_data{"fldStudio"}</td></tr>);
	print qq(<tr><td>$$form_data{"fldPurchased"}</td></tr>);
	print qq(<tr><td>$$form_data{"fldLastWatched"}</td></tr>);
	print qq(<tr><td>$$form_data{"fldShelf"}</td></tr>);
	print qq(</table></center>);
}

###############################################
#
# Description: Function used to edit Blu-Ray titles in the database
#
#
##################
sub editTitle {
	#
	# Get the reference to the form data
	#
	my ($form_data) = @_;
	print start_html(-title=>'Edit Title Subroutine');
	print h1("The editTitle subroutine was  called!");
	print qq(The Blu-Ray Title: $$form_data{"fldTitle"} would have been edited in the database.<br>);
	print qq(<center><table>);
	print qq(<th><td>Other Title Attributes</td></th>);
	print qq(<tr><td>$$form_data{"fldMPARating"}</td></tr>);
	print qq(<tr><td>$$form_data{"fldStudio"}</td></tr>);
	print qq(<tr><td>$$form_data{"fldPurchased"}</td></tr>);
	print qq(<tr><td>$$form_data{"fldLastWatched"}</td></tr>);
	print qq(<tr><td>$$form_data{"fldShelf"}</td></tr>);
	print qq(</table></center>);
}

###############################################
#
# Description: Function used to delete Blu-Ray titles from the database
#
#
##################
sub deleteTitle {
	#
	# Get the reference to the form data
	#
	my ($form_data) = @_;
	print start_html(-title=>'Delete Title Subroutine');
	print h1("The deleteTitle subroutine was  called!");
	print qq(The Blu-Ray Title: $$form_data{"fldTitle"} would have been deleted from the database.<br>);
	print qq(<center><table>);
	print qq(<th><td>Other Title Attributes</td></th>);
	print qq(<tr><td>$$form_data{"fldMPARating"}</td></tr>);
	print qq(<tr><td>$$form_data{"fldStudio"}</td></tr>);
	print qq(<tr><td>$$form_data{"fldPurchased"}</td></tr>);
	print qq(<tr><td>$$form_data{"fldLastWatched"}</td></tr>);
	print qq(<tr><td>$$form_data{"fldShelf"}</td></tr>);
	print qq(</table></center>);
}

