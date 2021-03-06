# Policyfile.rb - Describe how you want Chef to build your system.
#
# For more information on the Policyfile feature, visit
# https://github.com/chef/chef-dk/blob/master/POLICYFILE_README.md

name "tm-php"
default_source :supermarket
run_list "tm-php::hello", "tm-php::default"
named_run_list :myphp, "tm-php::default"
named_run_list :template_test, "tm-php::template_test"

# cookbook "tm-php", path: "." # Great for testing on workstation/mbp
cookbook "tm-php", github: "taylormonacelli/tm-php"
cookbook "vcruntime", ">= 0.2.2", github: "taylormonacelli/vcruntime", branch: 'tm/api-ms-win-crt-runtime-l1-1-0-dll'

# Great for testing without pushing to github:
# cookbook "vcruntime", ">= 0.2.2", path: "/Users/demo/pdev/TaylorMonacelli/vcruntime"
# cookbook "vcruntime", ">= 0.2.2", path: "/Users/demo/pdev/TaylorMonacelli/vcruntime", branch: 'tm/api-ms-win-crt-runtime-l1-1-0-dll'

# Examples:
#default['php']['install_dir'] = '/tmp'
#default['php']['version'] = '7.0.10'
#default['php']['environment'] = "production"
#default['php']['date.timezone'] = 'America/Los_Angeles'
