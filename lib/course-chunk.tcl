ad_page_contract {
    Displays the information of one course
    @author          Miguel Marin (miguelmarin@viaro.net) 
    @author          Viaro Networks www.viaro.net
    @creation-date   08-01-2005
} {

}

set dotlrn_url [dotlrn::get_url]
if { ![info exists index] } {
    set index ""
}

if { ![info exists asmid] } {
    set asmid "-1"
}