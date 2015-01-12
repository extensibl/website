open Tagffi
open Bootstrap3
open Csstheme

val bsTile3 = classes (classes (classes
                        Bootstrap3.b3_col_xs_12 
                        Bootstrap3.b3_col_sm_12   )
                        Bootstrap3.b3_col_md_4    )
                        Bootstrap3.b3_col_lg_3

val bsTile4 = classes (classes (classes
                        Bootstrap3.b3_col_xs_12 
                        Bootstrap3.b3_col_sm_12   )
                        Bootstrap3.b3_col_md_4    )
                        Bootstrap3.b3_col_lg_4

val bsTile6 = classes (classes (classes
                        Bootstrap3.b3_col_xs_12 
                        Bootstrap3.b3_col_sm_6    )
                        Bootstrap3.b3_col_md_6    )
                        Bootstrap3.b3_col_lg_6

val bsTile12 = classes (classes (classes
                        Bootstrap3.b3_col_xs_12 
                        Bootstrap3.b3_col_sm_12    )
                        Bootstrap3.b3_col_md_12    )
                        Bootstrap3.b3_col_lg_12

fun mkTile cssclass (content : xbody) : xbody = 
    <xml>
        <div class="cssclass">
            {content}
        </div>
    </xml>

fun mkTxtBlock (title : string) (content : xbody) : xbody = 
    <xml>
        <h3>{[title]}</h3>
        {content}
    </xml>

fun mkTel (tel:string) : xbody =
    <xml><a href={bless (strcat "tel:" tel)}>{[tel]}</a></xml>

fun mkNoSpamEmail (email : string) (pageLoaded : source bool) : transaction xbody = 
    return 
        <xml>
            <dyn signal={
                v <- signal pageLoaded;
                return (if v 
                        then <xml><a href={bless (strcat "mailto:" email)}>{[email]}</a></xml> 
                        else <xml/>)
            } />
        </xml>

fun mkSection (sectionId:id) (title:string) (content:xbody) : xbody =
    <xml>
        <div class="b3_container">
            <div class="b3_page_header">
                <span class="t_target" id={sectionId}></span>
                <h1>{[title]}</h1>
            </div>
            {content}
        </div>
    </xml>

fun mkClock (timeSource : source time) : transaction xbody = 
    return 
        <xml>
            <dyn signal={
                v <- signal timeSource;
                return <xml>{[v]}</xml>
            } />
        </xml>


fun idToHashUrl (i:id) : url = bless (strcat "#" (show i))

fun main () : transaction page = 
    
    pageLoaded   <- source False;
    
    idHeader     <- fresh;
    idAbout      <- fresh;
    idTalk       <- fresh;
    idExpertise  <- fresh;
    idPricing    <- fresh;
    idJobs       <- fresh;
    idContacts   <- fresh;
    
    emailClients <- mkNoSpamEmail "clients@extensibl.com" pageLoaded;
    emailJobs    <- mkNoSpamEmail "jobs@extensibl.com"    pageLoaded;

    return <xml>
    
        <head>
            <title>extensibl</title>
            <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/3.3.1/cosmo/bootstrap.min.css" />
            <link rel="stylesheet" type="text/css" href="/s/theme.css" />
            
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
            
            <!--[if lt IE 9]>
            <script src="/s/html5_shim.js"></script>
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <script src="/s/respond.min.js"></script>
            <![endif]-->
            
        </head>
        
        
        <body onload={set pageLoaded True} class="t_min_width_limit t_position_relative"  data-spy="scroll" data-offset="55" data-target=".floating_navigation">
        
            <div class="t_img_resp"></div>
            
            <div class="b3_text_center t_header_content">
                <a class="t_target" id={idHeader}></a>
                <h1 class="t_logo">extensibl</h1>
                <p class="b3_lead">Helping startups to succeed</p>
            </div>
        
            <div class="t_menu_wrap">
                <div class="t_menu">
                    <ul class="b3_nav b3_nav_pills b3_nav_justified"  role="navigation">
                        <li><a class="b3_btn b3_btn_default" href={idToHashUrl idHeader}>About</a></li>
                        <li><a class="b3_btn b3_btn_default" href={idToHashUrl idExpertise}>Expertise</a></li>
                        <li><a class="b3_btn b3_btn_default" href={idToHashUrl idPricing}>Pricing</a></li>
                        <li><a class="b3_btn b3_btn_default" href={idToHashUrl idJobs}>Jobs</a></li>
                        <li><a class="b3_btn b3_btn_default" href={idToHashUrl idContacts}>Contacts</a></li>
                    </ul>
                </div>
            </div>
            
            {mkSection idAbout "Consulting, software development services for start-ups"
                <xml>
                    <div class="b3_row">
                        {mkTile bsTile6
                            <xml>
                                <p>Free first consultation</p>
                                <p>Fast prototyping, development, setup. Technical assistance with non-trivial issues. Quick response times.</p>
                            </xml>}
                        {mkTile bsTile6
                            <xml>
                                <p>Personal, reliable service. Help with planning and project management. Discounts for the startups we like.</p>
                                <p>Talk to us today: {mkTel "+64220382907"}, {emailClients}</p>
                            </xml>}
                    </div>
                </xml>}
            
            {mkSection idExpertise "Expertise"
                <xml>
                    <div class="b3_row">
                        {mkTile bsTile3 (mkTxtBlock "Fast prototyping" 
                                    <xml>
                                        <p>We are ready to help when it is important to produce a working prototype by a given date.</p>
                                    </xml>)}
                        {mkTile bsTile3 (mkTxtBlock "General software development" 
                                    <xml>
                                        <p>We target tablet and mobile devices.</p>
                                        <p>Python, Haskell, Erlang, Ur/Web, AngularJS, Twitter Bootstrap are among the tools we use daily.</p>
                                        <p>Our preferred technology stack includes Haskell and Ur/Web for a good reason - strongly typed languages with clever compilers allow to build and then support high-quality, secure software easily. Modern Javascript and CSS frameworks help to create consistent and clean user interfaces on mobile, tablet and desktop devices.</p>
                                    </xml>)}
                        {mkTile bsTile3 (mkTxtBlock "Statistics, finance"
                                    <xml>
                                        <p>We do support and develop statistical, financial and data processing software, which includes neural network, genetic, support vector machines algorithms.</p>
                                        <p>We have capacity to setup high-volume and low latency APIs and storage.</p>
                                    </xml>)}
                        {mkTile bsTile3 (mkTxtBlock "Security" 
                                    <xml>
                                        <p>We choose software components carefully to maintain security of our solutions. We use OpenBSD on our servers when it is possible.</p>
                                        <p>Combined with proactive monitoring and rapid incident response speed, that eliminates many security risks.</p>
                                    </xml>)}

                    </div>
                    <div class="b3_row">
                        {mkTile bsTile3 (mkTxtBlock "Support" 
                                    <xml>
                                        <p>Extensibl provides full support for your application(s).</p>
                                        <p>That includes any ongoing maintenance and incident response</p>
                                    </xml>)}
                        {mkTile bsTile3 (mkTxtBlock "Project management" 
                                    <xml>
                                        <p>We are capable of managing projects from start to completion. </p>
                                    </xml>)}
                        {mkTile bsTile3 (mkTxtBlock "Open source" 
                                    <xml>
                                        <p>We use open-source software in our work. Check our contributions at <a href="https://github.com/extensibl">github.com/extensibl</a></p>
                                    </xml>)}
                        {mkTile bsTile3 (mkTxtBlock "Hosting" 
                                    <xml>
                                        <p>Cost-effective, performant, reliable hosting as well as server management are offered to all clients.</p>
                                        <p>We use best available infrastructure in datacentres located in Australia, United States, Europe.</p>
                                        <p>All clients can enjoy benefits of the quality content delivery network (CDN) which we use.</p>
                                    </xml>)}
                    </div>
                </xml>}
            
            {mkSection idPricing "Pricing"
                <xml>
                    <div class="b3_row">
                        {mkTile bsTile4 (mkTxtBlock "Consulting" 
                            <xml>
                                <p>For short engagements with no ongoing commitment Extensibl charges NZ$125/hour.</p>
                            </xml>)}
                        {mkTile bsTile4 (mkTxtBlock "Development & Operations" 
                            <xml>
                                <p>Hourly price for general software development is NZ$95.</p>
                                <p>Discounts are available for clients who provide minimum time commitments.</p>
                                <p>All clients can manage expenditure based on either full-project or per-month budgets.</p>
                            </xml>)}
                        {mkTile bsTile4 (mkTxtBlock "Service level agreements" 
                            <xml>
                                <p>Service level agreements are available for clients, who need guaranteed response times.</p>
                                <p>Monthly prices can vary from NZ$250 to NZ$4000 depending on response time and window (business hours only or 24x7) required.</p>
                            </xml>)}
                    </div>
                </xml>}
            
            
            {mkSection idJobs "We are hiring"
                <xml>
                    <div class="b3_row">
                        {mkTile bsTile12
                            <xml>
                                <p>We are actively looking to expand our team.</p>
                                <p>If have strong skills in software development and related areas, please send your resume to {emailJobs}.</p>
                                <p>Knowledge of mathematics or interest in finance would be advantageous.</p>
                            </xml>}
                    </div>
                </xml>
            }
                
            
            <div class="t_footer">
                {mkSection idContacts "Contact us"
                    <xml>
                        <div class="b3_row">
                        
                            {mkTile bsTile6 (mkTxtBlock "Urgent enquiries and support"
                                <xml>
                                    <p>Tel.: {mkTel "+64220382907"}</p>
                                    <h3>General enquiries</h3>
                                    <p>Email: {emailClients}</p>
                                </xml>)}
                                
                            {mkTile bsTile3 (mkTxtBlock "Mailing address"
                                <xml>
                                    <p>Universal Supply Limited</p>
                                    <p>PE/127 Grafton Road, Grafton, Auckland 1010, New Zealand</p>
                                </xml>)}
                            
                            {mkTile bsTile3 (mkTxtBlock "Company details"
                                <xml>
                                    <p>Company number
                                        <a href="http://www.business.govt.nz/companies/app/ui/pages/companies/5196441">5196441</a>
                                    </p>
                                </xml>)}
                        </div>
                    </xml>}

                <div class="b3_container">
                    <div class="b3_row">
                        <div class="b3_col_xs_12">
                            <p class="b3_text_center b3_text_muted">© Universal Supply Limited. Website created using <a href="http://impredicative.com/ur/">Ur/Web</a></p>
                        </div>
                    </div>
                </div>
                
            </div>

        </body>
    </xml>
