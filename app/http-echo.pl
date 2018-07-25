use Mojolicious::Lite;
use JSON::XS;

# data struct and onj init
my $json = JSON::XS->new->ascii->pretty;

plugin SetUserGroup => {user => "nobody", group => "nogroup"};

get '/' => {text => "HTTP Echo App\n"};

get '/echo' => sub {
    my ($c) = @_;
    my $response_text;
    $response_text .= "== Request method and path == \n". $c->req->method . ' ' . $c->req->url->to_string ."\n";
    $response_text .= "== Request Headers == \n". $json->encode($c->req->headers->to_hash) ."\n";
    $response_text .= "== Query Parameters == \n". $json->encode($c->req->params->to_hash) ."\n";

    $c->render(text => $response_text );
};

get '/term' => sub { exit 0; };

app->start;
