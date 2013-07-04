var config = new Settings(
{
  elasticsearch:    "http://172.16.10.15:9200",
  kibana_index:     "logs-current",
  modules:          ['histogram','map','pie','table','stringquery','sort',
                    'timepicker','text','fields','hits','dashcontrol',
                    'column','derivequeries','trends','bettermap'],
  }
);
