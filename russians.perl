while (<>) {
    if (/<ab>/) {
    s+/jat/;+&#1123;+g;
    s+/Jat/;+&#1122;+g;
    s+/jat/+&#1123;+g;
    s+/Jat/+&#1122;+g;
    s+JA +&#1071; +g;
    s+JA</ab+&#1071;</ab+g;
    s+ю+&#1071;+g;
    s+Й+&#1046;+g;
    s+VЪ++g;
}
    else
    {
	s+ю+\'+g;
	s+/jat/;+ě+g;
	s+/Jat/;+Ě+g;
	s+/jat/+ě+g;
	s+/Jat/+Ě+g;
    }
    print;
}
