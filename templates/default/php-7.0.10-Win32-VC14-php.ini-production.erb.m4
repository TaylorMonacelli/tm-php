[PHP]

;;;;;;;;;;;;;;;;;;;
; About php.ini   ;
;;;;;;;;;;;;;;;;;;;
; PHP's initialization file, generally called php.ini, is responsible for
; configuring many of the aspects of PHP's behavior.

; PHP attempts to find and load this configuration from a number of locations.
; The following is a summary of its search order:
; 1. SAPI module specific location.
; 2. The PHPRC environment variable. (As of PHP 5.2.0)
; 3. A number of predefined registry keys on Windows (As of PHP 5.2.0)
; 4. Current working directory (except CLI)
; 5. The web server's directory (for SAPI modules), or directory of PHP
; (otherwise in Windows)
; 6. The directory from the --with-config-file-path compile time option, or the
; Windows directory (C:\windows or C:\winnt)
; See the PHP docs for more specific information.
; http://php.net/configuration.file

; The syntax of the file is extremely simple.  Whitespace and lines
; beginning with a semicolon are silently ignored (as you probably guessed).
; Section headers (e.g. [Foo]) are also silently ignored, even though
; they might mean something in the future.

; Directives following the section heading [PATH=/www/mysite] only
; apply to PHP files in the /www/mysite directory.  Directives
; following the section heading [HOST=www.example.com] only apply to
; PHP files served from www.example.com.  Directives set in these
; special sections cannot be overridden by user-defined INI files or
; at runtime. Currently, [PATH=] and [HOST=] sections only work under
; CGI/FastCGI.
; http://php.net/ini.sections

; Directives are specified using the following syntax:
; directive = value
; Directive names are *case sensitive* - foo=bar is different from FOO=bar.
; Directives are variables used to configure PHP or PHP extensions.
; There is no name validation.  If PHP can't find an expected
; directive because it is not set or is mistyped, a default value will be used.

; The value can be a string, a number, a PHP constant (e.g. E_ALL or M_PI), one
; of the INI constants (On, Off, True, False, Yes, No and None) or an expression
; (e.g. E_ALL & ~E_NOTICE), a quoted string ("bar"), or a reference to a
; previously set variable or directive (e.g. ${foo})

; Expressions in the INI file are limited to bitwise operators and parentheses:
; |  bitwise OR
; ^  bitwise XOR
; &  bitwise AND
; ~  bitwise NOT
; !  boolean NOT

; Boolean flags can be turned on using the values 1, On, True or Yes.
; They can be turned off using the values 0, Off, False or No.

; An empty string can be denoted by simply not writing anything after the equal
; sign, or by using the None keyword:

;  foo =         ; sets foo to an empty string
;  foo = None    ; sets foo to an empty string
;  foo = "None"  ; sets foo to the string 'None'

; If you use constants in your value, and these constants belong to a
; dynamically loaded extension (either a PHP extension or a Zend extension),
; you may only use these constants *after* the line that loads the extension.

;;;;;;;;;;;;;;;;;;;
; About this file ;
;;;;;;;;;;;;;;;;;;;
; PHP comes packaged with two INI files. One that is recommended to be used
; in production environments and one that is recommended to be used in
; development environments.

; php.ini-production contains settings which hold security, performance and
; best practices at its core. But please be aware, these settings may break
; compatibility with older or less security conscience applications. We
; recommending using the production ini in production and testing environments.

; php.ini-development is very similar to its production variant, except it is
; much more verbose when it comes to errors. We recommend using the
; development version only in development environments, as errors shown to
; application users can inadvertently leak otherwise secure information.

; This is php.ini-production INI file.

;;;;;;;;;;;;;;;;;;;
; Quick Reference ;
;;;;;;;;;;;;;;;;;;;
; The following are all the settings which are different in either the production
; or development versions of the INIs with respect to PHP's default behavior.
; Please see the actual settings later in the document for more details as to why
; we recommend these changes in PHP's behavior.

; display_errors
;   Default Value: On
;   Development Value: On
;   Production Value: Off

; display_startup_errors
;   Default Value: Off
;   Development Value: On
;   Production Value: Off

; error_reporting
;   Default Value: E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED
;   Development Value: E_ALL
;   Production Value: E_ALL & ~E_DEPRECATED & ~E_STRICT

; html_errors
;   Default Value: On
;   Development Value: On
;   Production value: On

; log_errors
;   Default Value: Off
;   Development Value: On
;   Production Value: On

; max_input_time
;   Default Value: -1 (Unlimited)
;   Development Value: 60 (60 seconds)
;   Production Value: 60 (60 seconds)

; output_buffering
;   Default Value: Off
;   Development Value: 4096
;   Production Value: 4096

; register_argc_argv
;   Default Value: On
;   Development Value: Off
;   Production Value: Off

; request_order
;   Default Value: None
;   Development Value: "GP"
;   Production Value: "GP"

; session.gc_divisor
;   Default Value: 100
;   Development Value: 1000
;   Production Value: 1000

; session.hash_bits_per_character
;   Default Value: 4
;   Development Value: 5
;   Production Value: 5

; short_open_tag
;   Default Value: On
;   Development Value: Off
;   Production Value: Off

; track_errors
;   Default Value: Off
;   Development Value: On
;   Production Value: Off

; url_rewriter.tags
;   Default Value: "a=href,area=href,frame=src,form=,fieldset="
;   Development Value: "a=href,area=href,frame=src,input=src,form=fakeentry"
;   Production Value: "a=href,area=href,frame=src,input=src,form=fakeentry"

; variables_order
;   Default Value: "EGPCS"
;   Development Value: "GPCS"
;   Production Value: "GPCS"

;;;;;;;;;;;;;;;;;;;;
; php.ini Options  ;
;;;;;;;;;;;;;;;;;;;;
; Name for user-defined php.ini (.htaccess) files. Default is ".user.ini"
<% if node['php']['user_ini.filename']['value'] != '".user.ini"' %>user_ini.filename = "<%= node['php']['user_ini.filename']['value'] %>"<% else %>;user_ini.filename = ".user.ini"<% end %>

; To disable this feature set this option to empty value
<% if !node['php']['user_ini.filename']['enabled'] %>user_ini.filename = %>"<% else %>;user_ini.filename = <% end %>

; TTL for user-defined php.ini files (time-to-live) in seconds. Default is 300 seconds (5 minutes)
<% if node['php']['user_ini.cache_ttl'] != 300 %>user_ini.cache_ttl = <%= node['php']['user_ini.cache_ttl'] %><% else %>;user_ini.cache_ttl = 300<% end %>

;;;;;;;;;;;;;;;;;;;;
; Language Options ;
;;;;;;;;;;;;;;;;;;;;

; Enable the PHP scripting language engine under Apache.
; http://php.net/engine
engine = <%= node['php']['engine'] %>

; This directive determines whether or not PHP will recognize code between
; <? and ?> tags as PHP source which should be processed as such. It is
; generally recommended that <?php and ?> should be used and that this feature
; should be disabled, as enabling it may result in issues when generating XML
; documents, however this remains supported for backward compatibility reasons.
; Note that this directive does not control the <?= shorthand tag, which can be
; used regardless of this directive.
; Default Value: On
; Development Value: Off
; Production Value: Off
; http://php.net/short-open-tag
short_open_tag = <%= node['php']['short_open_tag'] %>

; The number of significant digits displayed in floating point numbers.
; http://php.net/precision
precision = <%= node['php']['precision'] %>

; Output buffering is a mechanism for controlling how much output data
; (excluding headers and cookies) PHP should keep internally before pushing that
; data to the client. If your application's output exceeds this setting, PHP
; will send that data in chunks of roughly the size you specify.
; Turning on this setting and managing its maximum buffer size can yield some
; interesting side-effects depending on your application and web server.
; You may be able to send headers and cookies after you've already sent output
; through print or echo. You also may see performance benefits if your server is
; emitting less packets due to buffered output versus PHP streaming the output
; as it gets it. On production servers, 4096 bytes is a good setting for performance
; reasons.
; Note: Output buffering can also be controlled via Output Buffering Control
;   functions.
; Possible Values:
;   On = Enabled and buffer is unlimited. (Use with caution)
;   Off = Disabled
;   Integer = Enables the buffer and sets its maximum size in bytes.
; Note: This directive is hardcoded to Off for the CLI SAPI
; Default Value: Off
; Development Value: 4096
; Production Value: 4096
; http://php.net/output-buffering
output_buffering = <%= node['php']['output_buffering'] %>

; You can redirect all of the output of your scripts to a function.  For
; example, if you set output_handler to "mb_output_handler", character
; encoding will be transparently converted to the specified encoding.
; Setting any output handler automatically turns on output buffering.
; Note: People who wrote portable scripts should not depend on this ini
;   directive. Instead, explicitly set the output handler using ob_start().
;   Using this ini directive may cause problems unless you know what script
;   is doing.
; Note: You cannot use both "mb_output_handler" with "ob_iconv_handler"
;   and you cannot use both "ob_gzhandler" and "zlib.output_compression".
; Note: output_handler must be empty if this is set 'On' !!!!
;   Instead you must use zlib.output_handler.
; http://php.net/output-handler
<% if !node['php']['output_handler'].to_s.empty? %>output_handler = <%= node['php']['output_handler'] %><% else %>;output_handler =<% end %>

; Transparent output compression using the zlib library
; Valid values for this option are 'off', 'on', or a specific buffer size
; to be used for compression (default is 4KB)
; Note: Resulting chunk size may vary due to nature of compression. PHP
;   outputs chunks that are few hundreds bytes each as a result of
;   compression. If you prefer a larger chunk size for better
;   performance, enable output_buffering in addition.
; Note: You need to use zlib.output_handler instead of the standard
;   output_handler, or otherwise the output will be corrupted.
; http://php.net/zlib.output-compression
zlib.output_compression = <%= node['php']['zlib.output_compression'] %>

; http://php.net/zlib.output-compression-level
<% if node['php']['zlib.output_compression_level'] != -1 %>zlib.output_compression_level = <%= node['php']['zlib.output_compression_level'] %><% else %>;zlib.output_compression_level = -1<% end %>

; You cannot specify additional output handlers if zlib.output_compression
; is activated here. This setting does the same as output_handler but in
; a different order.
; http://php.net/zlib.output-handler
<% if !node['php']['zlib.output_handler'].to_s.empty? %>zlib.output_handler = <%= node['php']['zlib.output_handler'] %><% else %>;zlib.output_handler =<% end %>

; Implicit flush tells PHP to tell the output layer to flush itself
; automatically after every output block.  This is equivalent to calling the
; PHP function flush() after each and every call to print() or echo() and each
; and every HTML block.  Turning this option on has serious performance
; implications and is generally recommended for debugging purposes only.
; http://php.net/implicit-flush
; Note: This directive is hardcoded to On for the CLI SAPI
implicit_flush = <%= node['php']['implicit_flush'] %>

; The unserialize callback function will be called (with the undefined class'
; name as parameter), if the unserializer finds an undefined class
; which should be instantiated. A warning appears if the specified function is
; not defined, or if the function doesn't include/implement the missing class.
; So only set this entry, if you really want to implement such a
; callback-function.
unserialize_callback_func =<%= node['php']['unserialize_callback_func'] %>

; When floats & doubles are serialized store serialize_precision significant
; digits after the floating point. The default value ensures that when floats
; are decoded with unserialize, the data will remain the same.
serialize_precision = <%= node['php']['serialize_precision'] %>

; open_basedir, if set, limits all file operations to the defined directory
; and below.  This directive makes most sense if used in a per-directory
; or per-virtualhost web server configuration file.
; http://php.net/open-basedir
<% if !node['php']['open_basedir'].to_s.empty? %>open_basedir = <%= node['php']['open_basedir'] %><% else %>;open_basedir =<% end %>

; This directive allows you to disable certain functions for security reasons.
; It receives a comma-delimited list of function names.
; http://php.net/disable-functions
disable_functions = <%= node['php']['disable_functions'] %>

; This directive allows you to disable certain classes for security reasons.
; It receives a comma-delimited list of class names.
; http://php.net/disable-classes
disable_classes = <%= node['php']['disable_classes'] %>

; Colors for Syntax Highlighting mode.  Anything that's acceptable in
; <span style="color: ???????"> would work.
; http://php.net/syntax-highlighting
<% if node['php']['highlight.string'] != '#DD0000' %>highlight.string = <%= node['php']['highlight.string'] %><% else %>;highlight.string  = #DD0000<% end %>
<% if node['php']['highlight.comment'] != '#FF9900' %>highlight.comment = <%= node['php']['highlight.comment'] %><% else %>;highlight.comment = #FF9900<% end %>
<% if node['php']['highlight.keyword'] != '#007700' %>highlight.keyword = <%= node['php']['highlight.keyword'] %><% else %>;highlight.keyword = #007700<% end %>
<% if node['php']['highlight.default'] != '#0000BB' %>highlight.default = <%= node['php']['highlight.default'] %><% else %>;highlight.default = #0000BB<% end %>
<% if node['php']['highlight.html'] != '#000000' %>highlight.html = <%= node['php']['highlight.html'] %><% else %>;highlight.html    = #000000<% end %>

; If enabled, the request will be allowed to complete even if the user aborts
; the request. Consider enabling it if executing long requests, which may end up
; being interrupted by the user or a browser timing out. PHP's default behavior
; is to disable this feature.
; http://php.net/ignore-user-abort
<% if node['php']['ignore_user_abort'] != 'On' %>ignore_user_abort = <%= node['php']['ignore_user_abort'] %><% else %>;ignore_user_abort = On<% end %>

; Determines the size of the realpath cache to be used by PHP. This value should
; be increased on systems where PHP opens many files to reflect the quantity of
; the file operations performed.
; http://php.net/realpath-cache-size
<% if node['php']['realpath_cache_size'] != '16k' %>realpath_cache_size = <%= node['php']['realpath_cache_size'] %><% else %>;realpath_cache_size = 16k<% end %>

; Duration of time, in seconds for which to cache realpath information for a given
; file or directory. For systems with rarely changing files, consider increasing this
; value.
; http://php.net/realpath-cache-ttl
<% if node['php']['realpath_cache_ttl'] != 120 %>realpath_cache_ttl = <%= node['php']['realpath_cache_ttl'] %><% else %>;realpath_cache_ttl = 120<% end %>

; Enables or disables the circular reference collector.
; http://php.net/zend.enable-gc
zend.enable_gc = <%= node['php']['zend.enable_gc'] %>

; If enabled, scripts may be written in encodings that are incompatible with
; the scanner.  CP936, Big5, CP949 and Shift_JIS are the examples of such
; encodings.  To use this feature, mbstring extension must be enabled.
; Default: Off
<% if node['php']['zend.multibyte'] != 'Off' %>zend.multibyte = <%= node['php']['zend.multibyte'] %><% else %>;zend.multibyte = Off<% end %>

; Allows to set the default encoding for the scripts.  This value will be used
; unless "declare(encoding=...)" directive appears at the top of the script.
; Only affects if zend.multibyte is set.
; Default: ""
<% if !node['php']['zend.script_encoding'].to_s.empty? %>zend.script_encoding = <%= node['php']['zend.script_encoding'] %><% else %>;zend.script_encoding =<% end %>

;;;;;;;;;;;;;;;;;
; Miscellaneous ;
;;;;;;;;;;;;;;;;;

; Decides whether PHP may expose the fact that it is installed on the server
; (e.g. by adding its signature to the Web server header).  It is no security
; threat in any way, but it makes it possible to determine whether you use PHP
; on your server or not.
; http://php.net/expose-php
expose_php = <%= node['php']['expose_php'] %>

;;;;;;;;;;;;;;;;;;;
; Resource Limits ;
;;;;;;;;;;;;;;;;;;;

; Maximum execution time of each script, in seconds
; http://php.net/max-execution-time
; Note: This directive is hardcoded to 0 for the CLI SAPI
max_execution_time = <%= node['php']['max_execution_time'] %>

; Maximum amount of time each script may spend parsing request data. It's a good
; idea to limit this time on productions servers in order to eliminate unexpectedly
; long running scripts.
; Note: This directive is hardcoded to -1 for the CLI SAPI
; Default Value: -1 (Unlimited)
; Development Value: 60 (60 seconds)
; Production Value: 60 (60 seconds)
; http://php.net/max-input-time
max_input_time = <%= node['php']['max_input_time'] %>

; Maximum input variable nesting level
; http://php.net/max-input-nesting-level
<% if node['php']['max_input_nesting_level'] != 64 %>max_input_nesting_level = <%= node['php']['max_input_nesting_level'] %><% else %>;max_input_nesting_level = 64<% end %>

; How many GET/POST/COOKIE input variables may be accepted
<% if node['php']['max_input_vars'] != 1000 %>max_input_vars = <%= node['php']['max_input_vars'] %><% else %>; max_input_vars = 1000<% end %>

; Maximum amount of memory a script may consume (128MB)
; http://php.net/memory-limit
memory_limit = <%= node['php']['memory_limit'] %>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Error handling and logging ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This directive informs PHP of which errors, warnings and notices you would like
; it to take action for. The recommended way of setting values for this
; directive is through the use of the error level constants and bitwise
; operators. The error level constants are below here for convenience as well as
; some common settings and their meanings.
; By default, PHP is set to take action on all errors, notices and warnings EXCEPT
; those related to E_NOTICE and E_STRICT, which together cover best practices and
; recommended coding standards in PHP. For performance reasons, this is the
; recommend error reporting setting. Your production server shouldn't be wasting
; resources complaining about best practices and coding standards. That's what
; development servers and development settings are for.
; Note: The php.ini-development file has this setting as E_ALL. This
; means it pretty much reports everything which is exactly what you want during
; development and early testing.
;
; Error Level Constants:
; E_ALL             - All errors and warnings (includes E_STRICT as of PHP 5.4.0)
; E_ERROR           - fatal run-time errors
; E_RECOVERABLE_ERROR  - almost fatal run-time errors
; E_WARNING         - run-time warnings (non-fatal errors)
; E_PARSE           - compile-time parse errors
; E_NOTICE          - run-time notices (these are warnings which often result
;                     from a bug in your code, but it's possible that it was
;                     intentional (e.g., using an uninitialized variable and
;                     relying on the fact it is automatically initialized to an
;                     empty string)
; E_STRICT          - run-time notices, enable to have PHP suggest changes
;                     to your code which will ensure the best interoperability
;                     and forward compatibility of your code
; E_CORE_ERROR      - fatal errors that occur during PHP's initial startup
; E_CORE_WARNING    - warnings (non-fatal errors) that occur during PHP's
;                     initial startup
; E_COMPILE_ERROR   - fatal compile-time errors
; E_COMPILE_WARNING - compile-time warnings (non-fatal errors)
; E_USER_ERROR      - user-generated error message
; E_USER_WARNING    - user-generated warning message
; E_USER_NOTICE     - user-generated notice message
; E_DEPRECATED      - warn about code that will not work in future versions
;                     of PHP
; E_USER_DEPRECATED - user-generated deprecation warnings
;
; Common Values:
;   E_ALL (Show all errors, warnings and notices including coding standards.)
;   E_ALL & ~E_NOTICE  (Show all errors, except for notices)
;   E_ALL & ~E_NOTICE & ~E_STRICT  (Show all errors, except for notices and coding standards warnings.)
;   E_COMPILE_ERROR|E_RECOVERABLE_ERROR|E_ERROR|E_CORE_ERROR  (Show only errors)
; Default Value: E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED
; Development Value: E_ALL
; Production Value: E_ALL & ~E_DEPRECATED & ~E_STRICT
; http://php.net/error-reporting
error_reporting = <%= node['php']['error_reporting'] %>

; This directive controls whether or not and where PHP will output errors,
; notices and warnings too. Error output is very useful during development, but
; it could be very dangerous in production environments. Depending on the code
; which is triggering the error, sensitive information could potentially leak
; out of your application such as database usernames and passwords or worse.
; For production environments, we recommend logging errors rather than
; sending them to STDOUT.
; Possible Values:
;   Off = Do not display any errors
;   stderr = Display errors to STDERR (affects only CGI/CLI binaries!)
;   On or stdout = Display errors to STDOUT
; Default Value: On
; Development Value: On
; Production Value: Off
; http://php.net/display-errors
display_errors = <%= node['php']['display_errors'] %>

; The display of errors which occur during PHP's startup sequence are handled
; separately from display_errors. PHP's default behavior is to suppress those
; errors from clients. Turning the display of startup errors on can be useful in
; debugging configuration problems. We strongly recommend you
; set this to 'off' for production servers.
; Default Value: Off
; Development Value: On
; Production Value: Off
; http://php.net/display-startup-errors
display_startup_errors = <%= node['php']['display_startup_errors'] %>

; Besides displaying errors, PHP can also log errors to locations such as a
; server-specific log, STDERR, or a location specified by the error_log
; directive found below. While errors should not be displayed on productions
; servers they should still be monitored and logging is a great way to do that.
; Default Value: Off
; Development Value: On
; Production Value: On
; http://php.net/log-errors
log_errors = <%= node['php']['log_errors'] %>

; Set maximum length of log_errors. In error_log information about the source is
; added. The default is 1024 and 0 allows to not apply any maximum length at all.
; http://php.net/log-errors-max-len
log_errors_max_len = <%= node['php']['log_errors_max_len'] %>

; Do not log repeated messages. Repeated errors must occur in same file on same
; line unless ignore_repeated_source is set true.
; http://php.net/ignore-repeated-errors
ignore_repeated_errors = <%= node['php']['ignore_repeated_errors'] %>

; Ignore source of message when ignoring repeated messages. When this setting
; is On you will not log errors with repeated messages from different files or
; source lines.
; http://php.net/ignore-repeated-source
ignore_repeated_source = <%= node['php']['ignore_repeated_source'] %>

; If this parameter is set to Off, then memory leaks will not be shown (on
; stdout or in the log). This has only effect in a debug compile, and if
; error reporting includes E_WARNING in the allowed list
; http://php.net/report-memleaks
report_memleaks = <%= node['php']['report_memleaks'] %>

; This setting is on by default.
<% if node['php']['report_zend_debug'] != 0 %>report_zend_debug = <%= node['php']['report_zend_debug'] %><% else %>;report_zend_debug = 0<% end %>

; Store the last error/warning message in $php_errormsg (boolean). Setting this value
; to On can assist in debugging and is appropriate for development servers. It should
; however be disabled on production servers.
; Default Value: Off
; Development Value: On
; Production Value: Off
; http://php.net/track-errors
track_errors = <%= node['php']['track_errors'] %>

; Turn off normal error reporting and emit XML-RPC error XML
; http://php.net/xmlrpc-errors
<% if node['php']['xmlrpc_errors'] != 0 %>xmlrpc_errors = <%= node['php']['xmlrpc_errors'] %><% else %>;xmlrpc_errors = 0<% end %>

; An XML-RPC faultCode
<% if node['php']['xmlrpc_error_number'] != 0 %>xmlrpc_error_number = <%= node['php']['xmlrpc_error_number'] %><% else %>;xmlrpc_error_number = 0<% end %>

; When PHP displays or logs an error, it has the capability of formatting the
; error message as HTML for easier reading. This directive controls whether
; the error message is formatted as HTML or not.
; Note: This directive is hardcoded to Off for the CLI SAPI
; Default Value: On
; Development Value: On
; Production value: On
; http://php.net/html-errors
html_errors = <%= node['php']['html_errors'] %>

; If html_errors is set to On *and* docref_root is not empty, then PHP
; produces clickable error messages that direct to a page describing the error
; or function causing the error in detail.
; You can download a copy of the PHP manual from http://php.net/docs
; and change docref_root to the base URL of your local copy including the
; leading '/'. You must also specify the file extension being used including
; the dot. PHP's default behavior is to leave these settings empty, in which
; case no links to documentation are generated.
; Note: Never use this feature for production boxes.
; http://php.net/docref-root
; Examples
<% if node['php']['docref_root'] != '"/phpmanual/"' %>docref_root = "<%= node['php']['docref_root'] %>"<% else %>;docref_root = "/phpmanual/"<% end %>

; http://php.net/docref-ext
<% if node['php']['docref_ext'] != '.html' %>docref_ext = <%= node['php']['docref_ext'] %><% else %>;docref_ext = .html<% end %>

; String to output before an error message. PHP's default behavior is to leave
; this setting blank.
; http://php.net/error-prepend-string
; Example:
<% if node['php']['error_prepend_string'] != %Q|"<span style='color: #ff0000'>"| %>error_prepend_string = "<%= node['php']['error_prepend_string'] %>"<% else %>;error_prepend_string = "<span style='color: #ff0000'>"<% end %>

; String to output after an error message. PHP's default behavior is to leave
; this setting blank.
; http://php.net/error-append-string
; Example:
<% if node['php']['error_append_string'] != '"</span>"' %>error_append_string = "<%= node['php']['error_append_string'] %>"<% else %>;error_append_string = "</span>"<% end %>

; Log errors to specified file. PHP's default behavior is to leave this value
; empty.
; http://php.net/error-log
; Example:
<% if !node['php']['error_log'].to_s.empty? %>error_log = <%= node['php']['error_log'] %><% else %>;error_log = php_errors.log<% end %>
; Log errors to syslog (Event Log on Windows).
;error_log = syslog

<% if node['php']['windows.show_crt_warning'] != 0 %>windows.show_crt_warning = <%= node['php']['windows.show_crt_warning'] %><% else %>;windows.show_crt_warning<% end %>
; Default value: 0
; Development value: 0
; Production value: 0

;;;;;;;;;;;;;;;;;
; Data Handling ;
;;;;;;;;;;;;;;;;;

; The separator used in PHP generated URLs to separate arguments.
; PHP's default setting is "&".
; http://php.net/arg-separator.output
; Example:
<% if node['php']['arg_separator.output'] != '"&amp;"' %>arg_separator.output = "<%= node['php']['arg_separator.output'] %>"<% else %>;arg_separator.output = "&amp;"<% end %>

; List of separator(s) used by PHP to parse input URLs into variables.
; PHP's default setting is "&".
; NOTE: Every character in this directive is considered as separator!
; http://php.net/arg-separator.input
; Example:
<% if node['php']['arg_separator.input'] != '";&"' %>arg_separator.input = "<%= node['php']['arg_separator.input'] %>"<% else %>;arg_separator.input = ";&"<% end %>

; This directive determines which super global arrays are registered when PHP
; starts up. G,P,C,E & S are abbreviations for the following respective super
; globals: GET, POST, COOKIE, ENV and SERVER. There is a performance penalty
; paid for the registration of these arrays and because ENV is not as commonly
; used as the others, ENV is not recommended on productions servers. You
; can still get access to the environment variables through getenv() should you
; need to.
; Default Value: "EGPCS"
; Development Value: "GPCS"
; Production Value: "GPCS";
; http://php.net/variables-order
variables_order = "<%= node['php']['variables_order'] %>"

; This directive determines which super global data (G,P & C) should be
; registered into the super global array REQUEST. If so, it also determines
; the order in which that data is registered. The values for this directive
; are specified in the same manner as the variables_order directive,
; EXCEPT one. Leaving this value empty will cause PHP to use the value set
; in the variables_order directive. It does not mean it will leave the super
; globals array REQUEST empty.
; Default Value: None
; Development Value: "GP"
; Production Value: "GP"
; http://php.net/request-order
request_order = "<%= node['php']['request_order'] %>"

; This directive determines whether PHP registers $argv & $argc each time it
; runs. $argv contains an array of all the arguments passed to PHP when a script
; is invoked. $argc contains an integer representing the number of arguments
; that were passed when the script was invoked. These arrays are extremely
; useful when running scripts from the command line. When this directive is
; enabled, registering these variables consumes CPU cycles and memory each time
; a script is executed. For performance reasons, this feature should be disabled
; on production servers.
; Note: This directive is hardcoded to On for the CLI SAPI
; Default Value: On
; Development Value: Off
; Production Value: Off
; http://php.net/register-argc-argv
register_argc_argv = <%= node['php']['register_argc_argv'] %>

; When enabled, the ENV, REQUEST and SERVER variables are created when they're
; first used (Just In Time) instead of when the script starts. If these
; variables are not used within a script, having this directive on will result
; in a performance gain. The PHP directive register_argc_argv must be disabled
; for this directive to have any affect.
; http://php.net/auto-globals-jit
auto_globals_jit = <%= node['php']['auto_globals_jit'] %>

; Whether PHP will read the POST data.
; This option is enabled by default.
; Most likely, you won't want to disable this option globally. It causes $_POST
; and $_FILES to always be empty; the only way you will be able to read the
; POST data will be through the php://input stream wrapper. This can be useful
; to proxy requests or to process the POST data in a memory efficient fashion.
; http://php.net/enable-post-data-reading
<% if node['php']['enable_post_data_reading'] != 'Off' %>enable_post_data_reading = <%= node['php']['enable_post_data_reading'] %><% else %>;enable_post_data_reading = Off<% end %>

; Maximum size of POST data that PHP will accept.
; Its value may be 0 to disable the limit. It is ignored if POST data reading
; is disabled through enable_post_data_reading.
; http://php.net/post-max-size
post_max_size = <%= node['php']['post_max_size'] %>

; Automatically add files before PHP document.
; http://php.net/auto-prepend-file
auto_prepend_file = <%= node['php']['auto_prepend_file'] %>

; Automatically add files after PHP document.
; http://php.net/auto-append-file
auto_append_file = <%= node['php']['auto_append_file'] %>

; By default, PHP will output a media type using the Content-Type header. To
; disable this, simply set it to be empty.
;
; PHP's built-in default media type is set to text/html.
; http://php.net/default-mimetype
default_mimetype = "<%= node['php']['default_mimetype'] %>"

; PHP's default character set is set to UTF-8.
; http://php.net/default-charset
default_charset = "<%= node['php']['default_charset'] %>"

; PHP internal character encoding is set to empty.
; If empty, default_charset is used.
; http://php.net/internal-encoding
<% if !node['php']['internal_encoding'].to_s.empty? %>internal_encoding = <%= node['php']['internal_encoding'] %><% else %>;internal_encoding =<% end %>

; PHP input character encoding is set to empty.
; If empty, default_charset is used.
; http://php.net/input-encoding
<% if !node['php']['input_encoding'].to_s.empty? %>input_encoding = <%= node['php']['input_encoding'] %><% else %>;input_encoding =<% end %>

; PHP output character encoding is set to empty.
; If empty, default_charset is used.
; See also output_buffer.
; http://php.net/output-encoding
<% if !node['php']['output_encoding'].to_s.empty? %>output_encoding = <%= node['php']['output_encoding'] %><% else %>;output_encoding =<% end %>

;;;;;;;;;;;;;;;;;;;;;;;;;
; Paths and Directories ;
;;;;;;;;;;;;;;;;;;;;;;;;;

; UNIX: "/path1:/path2"
;include_path = ".:/php/includes"
;
; Windows: "\path1;\path2"
<% if node['php']['include_path'] != %q{".;c:\php\includes"} %>include_path = "<%= node['php']['include_path'] %>"<% else %>;include_path = ".;c:\php\includes"<% end %>
;
; PHP's default setting for include_path is ".;/path/to/php/pear"
; http://php.net/include-path

; The root of the PHP pages, used only if nonempty.
; if PHP was not compiled with FORCE_REDIRECT, you SHOULD set doc_root
; if you are running php as a CGI under any web server (other than IIS)
; see documentation for security issues.  The alternate is to use the
; cgi.force_redirect configuration below
; http://php.net/doc-root
doc_root = <%= node['php']['doc_root'] %>

; The directory under which PHP opens the script using /~username used only
; if nonempty.
; http://php.net/user-dir
user_dir = <%= node['php']['user_dir'] %>

; Directory in which the loadable extensions (modules) reside.
; http://php.net/extension-dir
; extension_dir = "./"
; On windows:
<% if !node['php']['extension_dir'].to_s.empty? %>extension_dir = "<%= node['php']['extension_dir'] %>"<% else %>; extension_dir = "ext"<% end %>

; Directory where the temporary files should be placed.
; Defaults to the system default (see sys_get_temp_dir)
<% if node['php']['sys_temp_dir'] != '"/tmp"' %>sys_temp_dir = "<%= node['php']['sys_temp_dir'] %>"<% else %>; sys_temp_dir = "/tmp"<% end %>

; Whether or not to enable the dl() function.  The dl() function does NOT work
; properly in multithreaded servers, such as IIS or Zeus, and is automatically
; disabled on them.
; http://php.net/enable-dl
enable_dl = <%= node['php']['enable_dl'] %>

; cgi.force_redirect is necessary to provide security running PHP as a CGI under
; most web servers.  Left undefined, PHP turns this on by default.  You can
; turn it off here AT YOUR OWN RISK
; **You CAN safely turn this off for IIS, in fact, you MUST.**
; http://php.net/cgi.force-redirect
<% if node['php']['cgi.force_redirect'] != 1 %>cgi.force_redirect = <%= node['php']['cgi.force_redirect'] %><% else %>;cgi.force_redirect = 1<% end %>

; if cgi.nph is enabled it will force cgi to always sent Status: 200 with
; every request. PHP's default behavior is to disable this feature.
<% if node['php']['cgi.nph'] != 1 %>cgi.nph = <%= node['php']['cgi.nph'] %><% else %>;cgi.nph = 1<% end %>

; if cgi.force_redirect is turned on, and you are not running under Apache or Netscape
; (iPlanet) web servers, you MAY need to set an environment variable name that PHP
; will look for to know it is OK to continue execution.  Setting this variable MAY
; cause security issues, KNOW WHAT YOU ARE DOING FIRST.
; http://php.net/cgi.redirect-status-env
<% if !node['php']['cgi.redirect_status_env'].to_s.empty? %>cgi.redirect_status_env = <%= node['php']['cgi.redirect_status_env'] %><% else %>;cgi.redirect_status_env =<% end %>

; cgi.fix_pathinfo provides *real* PATH_INFO/PATH_TRANSLATED support for CGI.  PHP's
; previous behaviour was to set PATH_TRANSLATED to SCRIPT_FILENAME, and to not grok
; what PATH_INFO is.  For more information on PATH_INFO, see the cgi specs.  Setting
; this to 1 will cause PHP CGI to fix its paths to conform to the spec.  A setting
; of zero causes PHP to behave as before.  Default is 1.  You should fix your scripts
; to use SCRIPT_FILENAME rather than PATH_TRANSLATED.
; http://php.net/cgi.fix-pathinfo
<% if node['php']['cgi.fix_pathinfo'] != 1 %>cgi.fix_pathinfo = <%= node['php']['cgi.fix_pathinfo'] %><% else %>;cgi.fix_pathinfo=1<% end %>

; FastCGI under IIS (on WINNT based OS) supports the ability to impersonate
; security tokens of the calling client.  This allows IIS to define the
; security context that the request runs under.  mod_fastcgi under Apache
; does not currently support this feature (03/17/2002)
; Set to 1 if running under IIS.  Default is zero.
; http://php.net/fastcgi.impersonate
<% if node['php']['fastcgi.impersonate'] != 1 %>fastcgi.impersonate = <%= node['php']['fastcgi.impersonate'] %><% else %>;fastcgi.impersonate = 1<% end %>

; Disable logging through FastCGI connection. PHP's default behavior is to enable
; this feature.
<% if node['php']['fastcgi.logging'] != 0 %>fastcgi.logging = <%= node['php']['fastcgi.logging'] %><% else %>;fastcgi.logging = 0<% end %>

; cgi.rfc2616_headers configuration option tells PHP what type of headers to
; use when sending HTTP response code. If set to 0, PHP sends Status: header that
; is supported by Apache. When this option is set to 1, PHP will send
; RFC2616 compliant header.
; Default is zero.
; http://php.net/cgi.rfc2616-headers
<% if node['php']['cgi.rfc2616_headers'] != 0 %>cgi.rfc2616_headers = <%= node['php']['cgi.rfc2616_headers'] %><% else %>;cgi.rfc2616_headers = 0<% end %>

;;;;;;;;;;;;;;;;
; File Uploads ;
;;;;;;;;;;;;;;;;

; Whether to allow HTTP file uploads.
; http://php.net/file-uploads
file_uploads = <%= node['php']['file_uploads'] %>

; Temporary directory for HTTP uploaded files (will use system default if not
; specified).
; http://php.net/upload-tmp-dir
<% if !node['php']['upload_tmp_dir'].to_s.empty? %>upload_tmp_dir = <%= node['php']['upload_tmp_dir'] %><% else %>;upload_tmp_dir =<% end %>

; Maximum allowed size for uploaded files.
; http://php.net/upload-max-filesize
upload_max_filesize = <%= node['php']['upload_max_filesize'] %>

; Maximum number of files that can be uploaded via a single request
max_file_uploads = <%= node['php']['max_file_uploads'] %>

;;;;;;;;;;;;;;;;;;
; Fopen wrappers ;
;;;;;;;;;;;;;;;;;;

; Whether to allow the treatment of URLs (like http:// or ftp://) as files.
; http://php.net/allow-url-fopen
allow_url_fopen = <%= node['php']['allow_url_fopen'] %>

; Whether to allow include/require to open URLs (like http:// or ftp://) as files.
; http://php.net/allow-url-include
allow_url_include = <%= node['php']['allow_url_include'] %>

; Define the anonymous ftp password (your email address). PHP's default setting
; for this is empty.
; http://php.net/from
<% if node['php']['from'] != 'john@doe.com' %>from = "<%= node['php']['from'] %>"<% else %>;from="john@doe.com"<% end %>

; Define the User-Agent string. PHP's default setting for this is empty.
; http://php.net/user-agent
<% if node['php']['user_agent'] != '"PHP"' %>user_agent = "<%= node['php']['user_agent'] %>"<% else %>;user_agent="PHP"<% end %>

; Default timeout for socket based streams (seconds)
; http://php.net/default-socket-timeout
default_socket_timeout = <%= node['php']['default_socket_timeout'] %>

; If your scripts have to deal with files from Macintosh systems,
; or you are running on a Mac and need to deal with files from
; unix or win32 systems, setting this flag will cause PHP to
; automatically detect the EOL character in those files so that
; fgets() and file() will work regardless of the source of the file.
; http://php.net/auto-detect-line-endings
<% if node['php']['auto_detect_line_endings'] != 'Off' %>auto_detect_line_endings = <%= node['php']['auto_detect_line_endings'] %><% else %>;auto_detect_line_endings = Off<% end %>

;;;;;;;;;;;;;;;;;;;;;;
; Dynamic Extensions ;
;;;;;;;;;;;;;;;;;;;;;;

; If you wish to have an extension loaded automatically, use the following
; syntax:
;
;   extension=modulename.extension
;
; For example, on Windows:
;
;   extension=msql.dll
;
; ... or under UNIX:
;
;   extension=msql.so
;
; ... or with a path:
;
;   extension=/path/to/extension/msql.so
;
; If you only provide the name of the extension, PHP will look for it in its
; default extension directory.
;
; Windows Extensions
; Note that ODBC support is built in, so no dll is needed for it.
; Note that many DLL files are located in the extensions/ (PHP 4) ext/ (PHP 5+)
; extension folders as well as the separate PECL DLL download (PHP 5+).
; Be sure to appropriately set the extension_dir directive.
;
<% if !node['php']['php_bz2.dll']['enabled'] %>;<% end %>extension=php_bz2.dll
<% if !node['php']['php_curl.dll']['enabled'] %>;<% end %>extension=php_curl.dll
<% if !node['php']['php_fileinfo.dll']['enabled'] %>;<% end %>extension=php_fileinfo.dll
<% if !node['php']['php_ftp.dll']['enabled'] %>;<% end %>extension=php_ftp.dll
<% if !node['php']['php_gd2.dll']['enabled'] %>;<% end %>extension=php_gd2.dll
<% if !node['php']['php_gettext.dll']['enabled'] %>;<% end %>extension=php_gettext.dll
<% if !node['php']['php_gmp.dll']['enabled'] %>;<% end %>extension=php_gmp.dll
<% if !node['php']['php_intl.dll']['enabled'] %>;<% end %>extension=php_intl.dll
<% if !node['php']['php_imap.dll']['enabled'] %>;<% end %>extension=php_imap.dll
<% if !node['php']['php_interbase.dll']['enabled'] %>;<% end %>extension=php_interbase.dll
<% if !node['php']['php_ldap.dll']['enabled'] %>;<% end %>extension=php_ldap.dll
<% if !node['php']['php_mbstring.dll']['enabled'] %>;<% end %>extension=php_mbstring.dll
<% if !node['php']['php_exif.dll']['enabled'] %>;<% end %>extension=php_exif.dll      ; Must be after mbstring as it depends on it
<% if !node['php']['php_mysqli.dll']['enabled'] %>;<% end %>extension=php_mysqli.dll
<% if !node['php']['php_oci8_12c.dll']['enabled'] %>;<% end %>extension=php_oci8_12c.dll      ; Use with Oracle Database 12c Instant Client
<% if !node['php']['php_openssl.dll']['enabled'] %>;<% end %>extension=php_openssl.dll
<% if !node['php']['php_pdo_firebird.dll']['enabled'] %>;<% end %>extension=php_pdo_firebird.dll
<% if !node['php']['php_pdo_mysql.dll']['enabled'] %>;<% end %>extension=php_pdo_mysql.dll
<% if !node['php']['php_pdo_oci.dll']['enabled'] %>;<% end %>extension=php_pdo_oci.dll
<% if !node['php']['php_pdo_odbc.dll']['enabled'] %>;<% end %>extension=php_pdo_odbc.dll
<% if !node['php']['php_pdo_pgsql.dll']['enabled'] %>;<% end %>extension=php_pdo_pgsql.dll
<% if !node['php']['php_pdo_sqlite.dll']['enabled'] %>;<% end %>extension=php_pdo_sqlite.dll
<% if !node['php']['php_pgsql.dll']['enabled'] %>;<% end %>extension=php_pgsql.dll
<% if !node['php']['php_shmop.dll']['enabled'] %>;<% end %>extension=php_shmop.dll
<% if !node['php']['php_com_dotnet.dll']['enabled'] %>;<% end %>extension=php_com_dotnet.dll
<% if !node['php']['php_enchant.dll']['enabled'] %>;<% end %>extension=php_enchant.dll
<% if !node['php']['php_odbc.dll']['enabled'] %>;<% end %>extension=php_odbc.dll
<% if !node['php']['php_opcache.dll']['enabled'] %>;<% end %>extension=php_opcache.dll
<% if !node['php']['php_phpdbg_webhelper.dll']['enabled'] %>;<% end %>extension=php_phpdbg_webhelper.dll
<% if !node['php']['php_sysvshm.dll']['enabled'] %>;<% end %>extension=php_sysvshm.dll

; The MIBS data available in the PHP distribution must be installed.
; See http://www.php.net/manual/en/snmp.installation.php
<% if !node['php']['php_snmp.dll']['enabled'] %>;<% end %>extension=php_snmp.dll

<% if !node['php']['php_soap.dll']['enabled'] %>;<% end %>extension=php_soap.dll
<% if !node['php']['php_sockets.dll']['enabled'] %>;<% end %>extension=php_sockets.dll
<% if !node['php']['php_sqlite3.dll']['enabled'] %>;<% end %>extension=php_sqlite3.dll
<% if !node['php']['php_tidy.dll']['enabled'] %>;<% end %>extension=php_tidy.dll
<% if !node['php']['php_xmlrpc.dll']['enabled'] %>;<% end %>extension=php_xmlrpc.dll
<% if !node['php']['php_xsl.dll']['enabled'] %>;<% end %>extension=php_xsl.dll

;;;;;;;;;;;;;;;;;;;
; Module Settings ;
;;;;;;;;;;;;;;;;;;;

[CLI Server]
; Whether the CLI web server uses ANSI color coding in its terminal output.
cli_server.color = <%= node['php']['cli_server.color'] %>

[Date]
; Defines the default timezone used by the date functions
; http://php.net/date.timezone
<% if !node['php']['date.timezone'].to_s.empty? %>date.timezone = <%= node['php']['date.timezone'] %><% else %>;date.timezone =<% end %>

; http://php.net/date.default-latitude
<% if node['php']['date.default_latitude'] != 31.7667 %>date.default_latitude = <%= node['php']['date.default_latitude'] %><% else %>;date.default_latitude = 31.7667<% end %>

; http://php.net/date.default-longitude
<% if node['php']['date.default_longitude'] != 35.2333 %>date.default_longitude = <%= node['php']['date.default_longitude'] %><% else %>;date.default_longitude = 35.2333<% end %>

; http://php.net/date.sunrise-zenith
<% if node['php']['date.sunrise_zenith'] != 90.583333 %>date.sunrise_zenith = <%= node['php']['date.sunrise_zenith'] %><% else %>;date.sunrise_zenith = 90.583333<% end %>

; http://php.net/date.sunset-zenith
<% if node['php']['date.sunset_zenith'] != 90.583333 %>date.sunset_zenith = <%= node['php']['date.sunset_zenith'] %><% else %>;date.sunset_zenith = 90.583333<% end %>

[filter]
; http://php.net/filter.default
<% if node['php']['filter.default'] != 'unsafe_raw' %>filter.default = <%= node['php']['filter.default'] %><% else %>;filter.default = unsafe_raw<% end %>

; http://php.net/filter.default-flags
<% if !node['php']['filter.default_flags'].to_s.empty? %>filter.default_flags = <%= node['php']['filter.default_flags'] %><% else %>;filter.default_flags =<% end %>

[iconv]
; Use of this INI entry is deprecated, use global input_encoding instead.
; If empty, default_charset or input_encoding or iconv.input_encoding is used.
; The precedence is: default_charset < intput_encoding < iconv.input_encoding
<% if !node['php']['iconv.input_encoding'].to_s.empty? %>iconv.input_encoding = <%= node['php']['iconv.input_encoding'] %><% else %>;iconv.input_encoding =<% end %>

; Use of this INI entry is deprecated, use global internal_encoding instead.
; If empty, default_charset or internal_encoding or iconv.internal_encoding is used.
; The precedence is: default_charset < internal_encoding < iconv.internal_encoding
<% if !node['php']['iconv.internal_encoding'].to_s.empty? %>iconv.internal_encoding = <%= node['php']['iconv.internal_encoding'] %><% else %>;iconv.internal_encoding =<% end %>

; Use of this INI entry is deprecated, use global output_encoding instead.
; If empty, default_charset or output_encoding or iconv.output_encoding is used.
; The precedence is: default_charset < output_encoding < iconv.output_encoding
; To use an output encoding conversion, iconv's output handler must be set
; otherwise output encoding conversion cannot be performed.
<% if !node['php']['iconv.output_encoding'].to_s.empty? %>iconv.output_encoding = <%= node['php']['iconv.output_encoding'] %><% else %>;iconv.output_encoding =<% end %>

[intl]
<% if !node['php']['intl.default_locale'].to_s.empty? %>intl.default_locale = <%= node['php']['intl.default_locale'] %><% else %>;intl.default_locale =<% end %>
; This directive allows you to produce PHP errors when some error
; happens within intl functions. The value is the level of the error produced.
; Default is 0, which does not produce any errors.
<% if node['php']['intl.error_level'] != 'E_WARNING' %>intl.error_level = <%= node['php']['intl.error_level'] %><% else %>;intl.error_level = E_WARNING<% end %>
<% if node['php']['intl.use_exceptions'] != 0 %>intl.use_exceptions = <%= node['php']['intl.use_exceptions'] %><% else %>;intl.use_exceptions = 0<% end %>

[sqlite3]
<% if !node['php']['sqlite3.extension_dir'].to_s.empty? %>sqlite3.extension_dir = <%= node['php']['sqlite3.extension_dir'] %><% else %>;sqlite3.extension_dir =<% end %>

[Pcre]
;PCRE library backtracking limit.
; http://php.net/pcre.backtrack-limit
<% if node['php']['pcre.backtrack_limit'] != 100000 %>pcre.backtrack_limit = <%= node['php']['pcre.backtrack_limit'] %><% else %>;pcre.backtrack_limit=100000<% end %>

;PCRE library recursion limit.
;Please note that if you set this value to a high number you may consume all
;the available process stack and eventually crash PHP (due to reaching the
;stack size limit imposed by the Operating System).
; http://php.net/pcre.recursion-limit
<% if node['php']['pcre.recursion_limit'] != 100000 %>pcre.recursion_limit = <%= node['php']['pcre.recursion_limit'] %><% else %>;pcre.recursion_limit=100000<% end %>

;Enables or disables JIT compilation of patterns. This requires the PCRE
;library to be compiled with JIT support.
<% if node['php']['pcre.jit'] != 1 %>pcre.jit = <%= node['php']['pcre.jit'] %><% else %>;pcre.jit=1<% end %>

[Pdo]
; Whether to pool ODBC connections. Can be one of "strict", "relaxed" or "off"
; http://php.net/pdo-odbc.connection-pooling
<% if node['php']['pdo_odbc.connection_pooling'] != 'strict' %>pdo_odbc.connection_pooling = <%= node['php']['pdo_odbc.connection_pooling'] %><% else %>;pdo_odbc.connection_pooling=strict<% end %>

;pdo_odbc.db2_instance_name

[Pdo_mysql]
; If mysqlnd is used: Number of cache slots for the internal result set cache
; http://php.net/pdo_mysql.cache_size
pdo_mysql.cache_size = <%= node['php']['pdo_mysql.cache_size'] %>

; Default socket name for local MySQL connects.  If empty, uses the built-in
; MySQL defaults.
; http://php.net/pdo_mysql.default-socket
pdo_mysql.default_socket =<%= node['php']['pdo_mysql.default_socket'] %>

[Phar]
; http://php.net/phar.readonly
<% if node['php']['phar.readonly'] != 'On' %>phar.readonly = <%= node['php']['phar.readonly'] %><% else %>;phar.readonly = On<% end %>

; http://php.net/phar.require-hash
<% if node['php']['phar.require_hash'] != 'On' %>phar.require_hash = <%= node['php']['phar.require_hash'] %><% else %>;phar.require_hash = On<% end %>

<% if !node['php']['phar.cache_list'].to_s.empty? %>phar.cache_list = <%= node['php']['phar.cache_list'] %><% else %>;phar.cache_list =<% end %>

[mail function]
; For Win32 only.
; http://php.net/smtp
SMTP = <%= node['php']['SMTP'] %>
; http://php.net/smtp-port
smtp_port = <%= node['php']['smtp_port'] %>

; For Win32 only.
; http://php.net/sendmail-from
<% if node['php']['sendmail_from'] != 'me@example.com' %>sendmail_from = <%= node['php']['sendmail_from'] %><% else %>;sendmail_from = me@example.com<% end %>

; For Unix only.  You may supply arguments as well (default: "sendmail -t -i").
; http://php.net/sendmail-path
<% if !node['php']['sendmail_path'].to_s.empty? %>sendmail_path = <%= node['php']['sendmail_path'] %><% else %>;sendmail_path =<% end %>

; Force the addition of the specified parameters to be passed as extra parameters
; to the sendmail binary. These parameters will always replace the value of
; the 5th parameter to mail().
<% if !node['php']['mail.force_extra_parameters'].to_s.empty? %>mail.force_extra_parameters = <%= node['php']['mail.force_extra_parameters'] %><% else %>;mail.force_extra_parameters =<% end %>

; Add X-PHP-Originating-Script: that will include uid of the script followed by the filename
mail.add_x_header = <%= node['php']['mail.add_x_header'] %>

; The path to a log file that will log all mail() calls. Log entries include
; the full path of the script, line number, To address and headers.
<% if !node['php']['mail.log'].to_s.empty? %>mail.log = <%= node['php']['mail.log'] %><% else %>;mail.log =<% end %>
; Log mail to syslog (Event Log on Windows).
;mail.log = syslog

[SQL]
; http://php.net/sql.safe-mode
sql.safe_mode = <%= node['php']['sql.safe_mode'] %>

[ODBC]
; http://php.net/odbc.default-db
<% if node['php']['odbc.default_db'] != 'Not yet implemented' %>odbc.default_db = <%= node['php']['odbc.default_db'] %><% else %>;odbc.default_db    =  Not yet implemented<% end %>

; http://php.net/odbc.default-user
<% if node['php']['odbc.default_user'] != 'Not yet implemented' %>odbc.default_user = <%= node['php']['odbc.default_user'] %><% else %>;odbc.default_user  =  Not yet implemented<% end %>

; http://php.net/odbc.default-pw
<% if node['php']['odbc.default_pw'] != 'Not yet implemented' %>odbc.default_pw = <%= node['php']['odbc.default_pw'] %><% else %>;odbc.default_pw    =  Not yet implemented<% end %>

; Controls the ODBC cursor model.
; Default: SQL_CURSOR_STATIC (default).
;odbc.default_cursortype

; Allow or prevent persistent links.
; http://php.net/odbc.allow-persistent
odbc.allow_persistent = <%= node['php']['odbc.allow_persistent'] %>

; Check that a connection is still valid before reuse.
; http://php.net/odbc.check-persistent
odbc.check_persistent = <%= node['php']['odbc.check_persistent'] %>

; Maximum number of persistent links.  -1 means no limit.
; http://php.net/odbc.max-persistent
odbc.max_persistent = <%= node['php']['odbc.max_persistent'] %>

; Maximum number of links (persistent + non-persistent).  -1 means no limit.
; http://php.net/odbc.max-links
odbc.max_links = <%= node['php']['odbc.max_links'] %>

; Handling of LONG fields.  Returns number of bytes to variables.  0 means
; passthru.
; http://php.net/odbc.defaultlrl
odbc.defaultlrl = <%= node['php']['odbc.defaultlrl'] %>

; Handling of binary data.  0 means passthru, 1 return as is, 2 convert to char.
; See the documentation on odbc_binmode and odbc_longreadlen for an explanation
; of odbc.defaultlrl and odbc.defaultbinmode
; http://php.net/odbc.defaultbinmode
odbc.defaultbinmode = <%= node['php']['odbc.defaultbinmode'] %>

<% if node['php']['birdstep.max_links'] != -1 %>birdstep.max_links = <%= node['php']['birdstep.max_links'] %><% else %>;birdstep.max_links = -1<% end %>

[Interbase]
; Allow or prevent persistent links.
ibase.allow_persistent = <%= node['php']['ibase.allow_persistent'] %>

; Maximum number of persistent links.  -1 means no limit.
ibase.max_persistent = <%= node['php']['ibase.max_persistent'] %>

; Maximum number of links (persistent + non-persistent).  -1 means no limit.
ibase.max_links = <%= node['php']['ibase.max_links'] %>

; Default database name for ibase_connect().
<% if !node['php']['ibase.default_db'].to_s.empty? %>ibase.default_db = <%= node['php']['ibase.default_db'] %><% else %>;ibase.default_db =<% end %>

; Default username for ibase_connect().
<% if !node['php']['ibase.default_user'].to_s.empty? %>ibase.default_user = <%= node['php']['ibase.default_user'] %><% else %>;ibase.default_user =<% end %>

; Default password for ibase_connect().
<% if !node['php']['ibase.default_password'].to_s.empty? %>ibase.default_password = <%= node['php']['ibase.default_password'] %><% else %>;ibase.default_password =<% end %>

; Default charset for ibase_connect().
<% if !node['php']['ibase.default_charset'].to_s.empty? %>ibase.default_charset = <%= node['php']['ibase.default_charset'] %><% else %>;ibase.default_charset =<% end %>

; Default timestamp format.
ibase.timestampformat = "<%= node['php']['ibase.timestampformat'] %>"

; Default date format.
ibase.dateformat = "<%= node['php']['ibase.dateformat'] %>"

; Default time format.
ibase.timeformat = "<%= node['php']['ibase.timeformat'] %>"

[MySQLi]

; Maximum number of persistent links.  -1 means no limit.
; http://php.net/mysqli.max-persistent
mysqli.max_persistent = <%= node['php']['mysqli.max_persistent'] %>

; Allow accessing, from PHP's perspective, local files with LOAD DATA statements
; http://php.net/mysqli.allow_local_infile
<% if node['php']['mysqli.allow_local_infile'] != 'On' %>mysqli.allow_local_infile = <%= node['php']['mysqli.allow_local_infile'] %><% else %>;mysqli.allow_local_infile = On<% end %>

; Allow or prevent persistent links.
; http://php.net/mysqli.allow-persistent
mysqli.allow_persistent = <%= node['php']['mysqli.allow_persistent'] %>

; Maximum number of links.  -1 means no limit.
; http://php.net/mysqli.max-links
mysqli.max_links = <%= node['php']['mysqli.max_links'] %>

; If mysqlnd is used: Number of cache slots for the internal result set cache
; http://php.net/mysqli.cache_size
mysqli.cache_size = <%= node['php']['mysqli.cache_size'] %>

; Default port number for mysqli_connect().  If unset, mysqli_connect() will use
; the $MYSQL_TCP_PORT or the mysql-tcp entry in /etc/services or the
; compile-time value defined MYSQL_PORT (in that order).  Win32 will only look
; at MYSQL_PORT.
; http://php.net/mysqli.default-port
mysqli.default_port = <%= node['php']['mysqli.default_port'] %>

; Default socket name for local MySQL connects.  If empty, uses the built-in
; MySQL defaults.
; http://php.net/mysqli.default-socket
mysqli.default_socket = <%= node['php']['mysqli.default_socket'] %>

; Default host for mysql_connect() (doesn't apply in safe mode).
; http://php.net/mysqli.default-host
mysqli.default_host = <%= node['php']['mysqli.default_host'] %>

; Default user for mysql_connect() (doesn't apply in safe mode).
; http://php.net/mysqli.default-user
mysqli.default_user = <%= node['php']['mysqli.default_user'] %>

; Default password for mysqli_connect() (doesn't apply in safe mode).
; Note that this is generally a *bad* idea to store passwords in this file.
; *Any* user with PHP access can run 'echo get_cfg_var("mysqli.default_pw")
; and reveal this password!  And of course, any users with read access to this
; file will be able to reveal the password as well.
; http://php.net/mysqli.default-pw
mysqli.default_pw = <%= node['php']['mysqli.default_pw'] %>

; Allow or prevent reconnect
mysqli.reconnect = <%= node['php']['mysqli.reconnect'] %>

[mysqlnd]
; Enable / Disable collection of general statistics by mysqlnd which can be
; used to tune and monitor MySQL operations.
; http://php.net/mysqlnd.collect_statistics
mysqlnd.collect_statistics = <%= node['php']['mysqlnd.collect_statistics'] %>

; Enable / Disable collection of memory usage statistics by mysqlnd which can be
; used to tune and monitor MySQL operations.
; http://php.net/mysqlnd.collect_memory_statistics
mysqlnd.collect_memory_statistics = <%= node['php']['mysqlnd.collect_memory_statistics'] %>

; Size of a pre-allocated buffer used when sending commands to MySQL in bytes.
; http://php.net/mysqlnd.net_cmd_buffer_size
<% if node['php']['mysqlnd.net_cmd_buffer_size'] != 2048 %>mysqlnd.net_cmd_buffer_size = <%= node['php']['mysqlnd.net_cmd_buffer_size'] %><% else %>;mysqlnd.net_cmd_buffer_size = 2048<% end %>

; Size of a pre-allocated buffer used for reading data sent by the server in
; bytes.
; http://php.net/mysqlnd.net_read_buffer_size
<% if node['php']['mysqlnd.net_read_buffer_size'] != 32768 %>mysqlnd.net_read_buffer_size = <%= node['php']['mysqlnd.net_read_buffer_size'] %><% else %>;mysqlnd.net_read_buffer_size = 32768<% end %>

[OCI8]

; Connection: Enables privileged connections using external
; credentials (OCI_SYSOPER, OCI_SYSDBA)
; http://php.net/oci8.privileged-connect
<% if node['php']['oci8.privileged_connect'] != 'Off' %>oci8.privileged_connect = <%= node['php']['oci8.privileged_connect'] %><% else %>;oci8.privileged_connect = Off<% end %>

; Connection: The maximum number of persistent OCI8 connections per
; process. Using -1 means no limit.
; http://php.net/oci8.max-persistent
<% if node['php']['oci8.max_persistent'] != -1 %>oci8.max_persistent = <%= node['php']['oci8.max_persistent'] %><% else %>;oci8.max_persistent = -1<% end %>

; Connection: The maximum number of seconds a process is allowed to
; maintain an idle persistent connection. Using -1 means idle
; persistent connections will be maintained forever.
; http://php.net/oci8.persistent-timeout
<% if node['php']['oci8.persistent_timeout'] != -1 %>oci8.persistent_timeout = <%= node['php']['oci8.persistent_timeout'] %><% else %>;oci8.persistent_timeout = -1<% end %>

; Connection: The number of seconds that must pass before issuing a
; ping during oci_pconnect() to check the connection validity. When
; set to 0, each oci_pconnect() will cause a ping. Using -1 disables
; pings completely.
; http://php.net/oci8.ping-interval
<% if node['php']['oci8.ping_interval'] != 60 %>oci8.ping_interval = <%= node['php']['oci8.ping_interval'] %><% else %>;oci8.ping_interval = 60<% end %>

; Connection: Set this to a user chosen connection class to be used
; for all pooled server requests with Oracle 11g Database Resident
; Connection Pooling (DRCP).  To use DRCP, this value should be set to
; the same string for all web servers running the same application,
; the database pool must be configured, and the connection string must
; specify to use a pooled server.
<% if !node['php']['oci8.connection_class'].to_s.empty? %>oci8.connection_class = <%= node['php']['oci8.connection_class'] %><% else %>;oci8.connection_class =<% end %>

; High Availability: Using On lets PHP receive Fast Application
; Notification (FAN) events generated when a database node fails. The
; database must also be configured to post FAN events.
<% if node['php']['oci8.events'] != 'Off' %>oci8.events = <%= node['php']['oci8.events'] %><% else %>;oci8.events = Off<% end %>

; Tuning: This option enables statement caching, and specifies how
; many statements to cache. Using 0 disables statement caching.
; http://php.net/oci8.statement-cache-size
<% if node['php']['oci8.statement_cache_size'] != 20 %>oci8.statement_cache_size = <%= node['php']['oci8.statement_cache_size'] %><% else %>;oci8.statement_cache_size = 20<% end %>

; Tuning: Enables statement prefetching and sets the default number of
; rows that will be fetched automatically after statement execution.
; http://php.net/oci8.default-prefetch
<% if node['php']['oci8.default_prefetch'] != 100 %>oci8.default_prefetch = <%= node['php']['oci8.default_prefetch'] %><% else %>;oci8.default_prefetch = 100<% end %>

; Compatibility. Using On means oci_close() will not close
; oci_connect() and oci_new_connect() connections.
; http://php.net/oci8.old-oci-close-semantics
<% if node['php']['oci8.old_oci_close_semantics'] != 'Off' %>oci8.old_oci_close_semantics = <%= node['php']['oci8.old_oci_close_semantics'] %><% else %>;oci8.old_oci_close_semantics = Off<% end %>

[PostgreSQL]
; Allow or prevent persistent links.
; http://php.net/pgsql.allow-persistent
pgsql.allow_persistent = <%= node['php']['pgsql.allow_persistent'] %>

; Detect broken persistent links always with pg_pconnect().
; Auto reset feature requires a little overheads.
; http://php.net/pgsql.auto-reset-persistent
pgsql.auto_reset_persistent = <%= node['php']['pgsql.auto_reset_persistent'] %>

; Maximum number of persistent links.  -1 means no limit.
; http://php.net/pgsql.max-persistent
pgsql.max_persistent = <%= node['php']['pgsql.max_persistent'] %>

; Maximum number of links (persistent+non persistent).  -1 means no limit.
; http://php.net/pgsql.max-links
pgsql.max_links = <%= node['php']['pgsql.max_links'] %>

; Ignore PostgreSQL backends Notice message or not.
; Notice message logging require a little overheads.
; http://php.net/pgsql.ignore-notice
pgsql.ignore_notice = <%= node['php']['pgsql.ignore_notice'] %>

; Log PostgreSQL backends Notice message or not.
; Unless pgsql.ignore_notice=0, module cannot log notice message.
; http://php.net/pgsql.log-notice
pgsql.log_notice = <%= node['php']['pgsql.log_notice'] %>

[bcmath]
; Number of decimal digits for all bcmath functions.
; http://php.net/bcmath.scale
bcmath.scale = <%= node['php']['bcmath.scale'] %>

[browscap]
; http://php.net/browscap
<% if node['php']['browscap'] != 'extra/browscap.ini' %>browscap = <%= node['php']['browscap'] %><% else %>;browscap = extra/browscap.ini<% end %>

[Session]
; Handler used to store/retrieve data.
; http://php.net/session.save-handler
session.save_handler = <%= node['php']['session.save_handler'] %>

; Argument passed to save_handler.  In the case of files, this is the path
; where data files are stored. Note: Windows users have to change this
; variable in order to use PHP's session functions.
;
; The path can be defined as:
;
;     session.save_path = "N;/path"
;
; where N is an integer.  Instead of storing all the session files in
; /path, what this will do is use subdirectories N-levels deep, and
; store the session data in those directories.  This is useful if
; your OS has problems with many files in one directory, and is
; a more efficient layout for servers that handle many sessions.
;
; NOTE 1: PHP will not create this directory structure automatically.
;         You can use the script in the ext/session dir for that purpose.
; NOTE 2: See the section on garbage collection below if you choose to
;         use subdirectories for session storage
;
; The file storage module creates files using mode 600 by default.
; You can change that by using
;
;     session.save_path = "N;MODE;/path"
;
; where MODE is the octal representation of the mode. Note that this
; does not overwrite the process's umask.
; http://php.net/session.save-path
<% if node['php']['session.save_path'] != '"/tmp"' %>session.save_path = "<%= node['php']['session.save_path'] %>"<% else %>;session.save_path = "/tmp"<% end %>

; Whether to use strict session mode.
; Strict session mode does not accept uninitialized session ID and regenerate
; session ID if browser sends uninitialized session ID. Strict mode protects
; applications from session fixation via session adoption vulnerability. It is
; disabled by default for maximum compatibility, but enabling it is encouraged.
; https://wiki.php.net/rfc/strict_sessions
session.use_strict_mode = <%= node['php']['session.use_strict_mode'] %>

; Whether to use cookies.
; http://php.net/session.use-cookies
session.use_cookies = <%= node['php']['session.use_cookies'] %>

; http://php.net/session.cookie-secure
<% if !node['php']['session.cookie_secure'].to_s.empty? %>session.cookie_secure = <%= node['php']['session.cookie_secure'] %><% else %>;session.cookie_secure =<% end %>

; This option forces PHP to fetch and use a cookie for storing and maintaining
; the session id. We encourage this operation as it's very helpful in combating
; session hijacking when not specifying and managing your own session id. It is
; not the be-all and end-all of session hijacking defense, but it's a good start.
; http://php.net/session.use-only-cookies
session.use_only_cookies = <%= node['php']['session.use_only_cookies'] %>

; Name of the session (used as cookie name).
; http://php.net/session.name
session.name = <%= node['php']['session.name'] %>

; Initialize session on request startup.
; http://php.net/session.auto-start
session.auto_start = <%= node['php']['session.auto_start'] %>

; Lifetime in seconds of cookie or, if 0, until browser is restarted.
; http://php.net/session.cookie-lifetime
session.cookie_lifetime = <%= node['php']['session.cookie_lifetime'] %>

; The path for which the cookie is valid.
; http://php.net/session.cookie-path
session.cookie_path = <%= node['php']['session.cookie_path'] %>

; The domain for which the cookie is valid.
; http://php.net/session.cookie-domain
session.cookie_domain = <%= node['php']['session.cookie_domain'] %>

; Whether or not to add the httpOnly flag to the cookie, which makes it inaccessible to browser scripting languages such as JavaScript.
; http://php.net/session.cookie-httponly
session.cookie_httponly = <%= node['php']['session.cookie_httponly'] %>

; Handler used to serialize data.  php is the standard serializer of PHP.
; http://php.net/session.serialize-handler
session.serialize_handler = <%= node['php']['session.serialize_handler'] %>

; Defines the probability that the 'garbage collection' process is started
; on every session initialization. The probability is calculated by using
; gc_probability/gc_divisor. Where session.gc_probability is the numerator
; and gc_divisor is the denominator in the equation. Setting this value to 1
; when the session.gc_divisor value is 100 will give you approximately a 1% chance
; the gc will run on any give request.
; Default Value: 1
; Development Value: 1
; Production Value: 1
; http://php.net/session.gc-probability
session.gc_probability = <%= node['php']['session.gc_probability'] %>

; Defines the probability that the 'garbage collection' process is started on every
; session initialization. The probability is calculated by using the following equation:
; gc_probability/gc_divisor. Where session.gc_probability is the numerator and
; session.gc_divisor is the denominator in the equation. Setting this value to 1
; when the session.gc_divisor value is 100 will give you approximately a 1% chance
; the gc will run on any give request. Increasing this value to 1000 will give you
; a 0.1% chance the gc will run on any give request. For high volume production servers,
; this is a more efficient approach.
; Default Value: 100
; Development Value: 1000
; Production Value: 1000
; http://php.net/session.gc-divisor
session.gc_divisor = <%= node['php']['session.gc_divisor'] %>

; After this number of seconds, stored data will be seen as 'garbage' and
; cleaned up by the garbage collection process.
; http://php.net/session.gc-maxlifetime
session.gc_maxlifetime = <%= node['php']['session.gc_maxlifetime'] %>

; NOTE: If you are using the subdirectory option for storing session files
;       (see session.save_path above), then garbage collection does *not*
;       happen automatically.  You will need to do your own garbage
;       collection through a shell script, cron entry, or some other method.
;       For example, the following script would is the equivalent of
;       setting session.gc_maxlifetime to 1440 (1440 seconds = 24 minutes):
;          find /path/to/sessions -cmin +24 -type f | xargs rm

; Check HTTP Referer to invalidate externally stored URLs containing ids.
; HTTP_REFERER has to contain this substring for the session to be
; considered as valid.
; http://php.net/session.referer-check
session.referer_check = <%= node['php']['session.referer_check'] %>

; How many bytes to read from the file.
; http://php.net/session.entropy-length
<% if node['php']['session.entropy_length'] != 32 %>session.entropy_length = <%= node['php']['session.entropy_length'] %><% else %>;session.entropy_length = 32<% end %>

; Specified here to create the session id.
; http://php.net/session.entropy-file
; Defaults to /dev/urandom
; On systems that don't have /dev/urandom but do have /dev/arandom, this will default to /dev/arandom
; If neither are found at compile time, the default is no entropy file.
; On windows, setting the entropy_length setting will activate the
; Windows random source (using the CryptoAPI)
<% if node['php']['session.entropy_file'] != '/dev/urandom' %>session.entropy_file = <%= node['php']['session.entropy_file'] %><% else %>;session.entropy_file = /dev/urandom<% end %>

; Set to {nocache,private,public,} to determine HTTP caching aspects
; or leave this empty to avoid sending anti-caching headers.
; http://php.net/session.cache-limiter
session.cache_limiter = <%= node['php']['session.cache_limiter'] %>

; Document expires after n minutes.
; http://php.net/session.cache-expire
session.cache_expire = <%= node['php']['session.cache_expire'] %>

; trans sid support is disabled by default.
; Use of trans sid may risk your users' security.
; Use this option with caution.
; - User may send URL contains active session ID
;   to other person via. email/irc/etc.
; - URL that contains active session ID may be stored
;   in publicly accessible computer.
; - User may access your site with the same session ID
;   always using URL stored in browser's history or bookmarks.
; http://php.net/session.use-trans-sid
session.use_trans_sid = <%= node['php']['session.use_trans_sid'] %>

; Select a hash function for use in generating session ids.
; Possible Values
;   0  (MD5 128 bits)
;   1  (SHA-1 160 bits)
; This option may also be set to the name of any hash function supported by
; the hash extension. A list of available hashes is returned by the hash_algos()
; function.
; http://php.net/session.hash-function
session.hash_function = <%= node['php']['session.hash_function'] %>

; Define how many bits are stored in each character when converting
; the binary hash data to something readable.
; Possible values:
;   4  (4 bits: 0-9, a-f)
;   5  (5 bits: 0-9, a-v)
;   6  (6 bits: 0-9, a-z, A-Z, "-", ",")
; Default Value: 4
; Development Value: 5
; Production Value: 5
; http://php.net/session.hash-bits-per-character
session.hash_bits_per_character = <%= node['php']['session.hash_bits_per_character'] %>

; The URL rewriter will look for URLs in a defined set of HTML tags.
; form/fieldset are special; if you include them here, the rewriter will
; add a hidden <input> field with the info which is otherwise appended
; to URLs.  If you want XHTML conformity, remove the form entry.
; Note that all valid entries require a "=", even if no value follows.
; Default Value: "a=href,area=href,frame=src,form=,fieldset="
; Development Value: "a=href,area=href,frame=src,input=src,form=fakeentry"
; Production Value: "a=href,area=href,frame=src,input=src,form=fakeentry"
; http://php.net/url-rewriter.tags
url_rewriter.tags = "<%= node['php']['url_rewriter.tags'] %>"

; Enable upload progress tracking in $_SESSION
; Default Value: On
; Development Value: On
; Production Value: On
; http://php.net/session.upload-progress.enabled
<% if node['php']['session.upload_progress.enabled'] != 'On' %>session.upload_progress.enabled = <%= node['php']['session.upload_progress.enabled'] %><% else %>;session.upload_progress.enabled = On<% end %>

; Cleanup the progress information as soon as all POST data has been read
; (i.e. upload completed).
; Default Value: On
; Development Value: On
; Production Value: On
; http://php.net/session.upload-progress.cleanup
<% if node['php']['session.upload_progress.cleanup'] != 'On' %>session.upload_progress.cleanup = <%= node['php']['session.upload_progress.cleanup'] %><% else %>;session.upload_progress.cleanup = On<% end %>

; A prefix used for the upload progress key in $_SESSION
; Default Value: "upload_progress_"
; Development Value: "upload_progress_"
; Production Value: "upload_progress_"
; http://php.net/session.upload-progress.prefix
<% if node['php']['session.upload_progress.prefix'] != '"upload_progress_"' %>session.upload_progress.prefix = "<%= node['php']['session.upload_progress.prefix'] %>"<% else %>;session.upload_progress.prefix = "upload_progress_"<% end %>

; The index name (concatenated with the prefix) in $_SESSION
; containing the upload progress information
; Default Value: "PHP_SESSION_UPLOAD_PROGRESS"
; Development Value: "PHP_SESSION_UPLOAD_PROGRESS"
; Production Value: "PHP_SESSION_UPLOAD_PROGRESS"
; http://php.net/session.upload-progress.name
<% if node['php']['session.upload_progress.name'] != '"PHP_SESSION_UPLOAD_PROGRESS"' %>session.upload_progress.name = "<%= node['php']['session.upload_progress.name'] %>"<% else %>;session.upload_progress.name = "PHP_SESSION_UPLOAD_PROGRESS"<% end %>

; How frequently the upload progress should be updated.
; Given either in percentages (per-file), or in bytes
; Default Value: "1%"
; Development Value: "1%"
; Production Value: "1%"
; http://php.net/session.upload-progress.freq
<% if node['php']['session.upload_progress.freq'] != '"1%"' %>session.upload_progress.freq = "<%= node['php']['session.upload_progress.freq'] %>"<% else %>;session.upload_progress.freq =  "1%"<% end %>

; The minimum delay between updates, in seconds
; Default Value: 1
; Development Value: 1
; Production Value: 1
; http://php.net/session.upload-progress.min-freq
<% if node['php']['session.upload_progress.min_freq'] != '"1"' %>session.upload_progress.min_freq = "<%= node['php']['session.upload_progress.min_freq'] %>"<% else %>;session.upload_progress.min_freq = "1"<% end %>

; Only write session data when session data is changed. Enabled by default.
; http://php.net/session.lazy-write
<% if node['php']['session.lazy_write'] != 'On' %>session.lazy_write = <%= node['php']['session.lazy_write'] %><% else %>;session.lazy_write = On<% end %>

[Assertion]
; Switch whether to compile assertions at all (to have no overhead at run-time)
; -1: Do not compile at all
;  0: Jump over assertion at run-time
;  1: Execute assertions
; Changing from or to a negative value is only possible in php.ini! (For turning assertions on and off at run-time, see assert.active, when zend.assertions = 1)
; Default Value: 1
; Development Value: 1
; Production Value: -1
; http://php.net/zend.assertions
zend.assertions = <%= node['php']['zend.assertions'] %>

; Assert(expr); active by default.
; http://php.net/assert.active
<% if node['php']['assert.active'] != 'On' %>assert.active = <%= node['php']['assert.active'] %><% else %>;assert.active = On<% end %>

; Throw an AssertationException on failed assertions
; http://php.net/assert.exception
<% if node['php']['assert.exception'] != 'On' %>assert.exception = <%= node['php']['assert.exception'] %><% else %>;assert.exception = On<% end %>

; Issue a PHP warning for each failed assertion. (Overridden by assert.exception if active)
; http://php.net/assert.warning
<% if node['php']['assert.warning'] != 'On' %>assert.warning = <%= node['php']['assert.warning'] %><% else %>;assert.warning = On<% end %>

; Don't bail out by default.
; http://php.net/assert.bail
<% if node['php']['assert.bail'] != 'Off' %>assert.bail = <%= node['php']['assert.bail'] %><% else %>;assert.bail = Off<% end %>

; User-function to be called if an assertion fails.
; http://php.net/assert.callback
<% if node['php']['assert.callback'] != 0 %>assert.callback = <%= node['php']['assert.callback'] %><% else %>;assert.callback = 0<% end %>

`; Eval the expression with current error_reporting().  Set to true if you want
; error_reporting(0) around the eval().
; http://php.net/assert.quiet-eval'
<% if node['php']['assert.quiet_eval'] != 0 %>assert.quiet_eval = <%= node['php']['assert.quiet_eval'] %><% else %>;assert.quiet_eval = 0<% end %>

[COM]
; path to a file containing GUIDs, IIDs or filenames of files with TypeLibs
; http://php.net/com.typelib-file
<% if !node['php']['com.typelib_file'].to_s.empty? %>com.typelib_file = <%= node['php']['com.typelib_file'] %><% else %>;com.typelib_file =<% end %>

; allow Distributed-COM calls
; http://php.net/com.allow-dcom
<% if node['php']['com.allow_dcom'] != 'true' %>com.allow_dcom = <%= node['php']['com.allow_dcom'] %><% else %>;com.allow_dcom = true<% end %>

; autoregister constants of a components typlib on com_load()
; http://php.net/com.autoregister-typelib
<% if node['php']['com.autoregister_typelib'] != 'true' %>com.autoregister_typelib = <%= node['php']['com.autoregister_typelib'] %><% else %>;com.autoregister_typelib = true<% end %>

; register constants casesensitive
; http://php.net/com.autoregister-casesensitive
<% if node['php']['com.autoregister_casesensitive'] != 'false' %>com.autoregister_casesensitive = <%= node['php']['com.autoregister_casesensitive'] %><% else %>;com.autoregister_casesensitive = false<% end %>

; show warnings on duplicate constant registrations
; http://php.net/com.autoregister-verbose
<% if node['php']['com.autoregister_verbose'] != 'true' %>com.autoregister_verbose = <%= node['php']['com.autoregister_verbose'] %><% else %>;com.autoregister_verbose = true<% end %>

; The default character set code-page to use when passing strings to and from COM objects.
; Default: system ANSI code page
<% if !node['php']['com.code_page'].to_s.empty? %>com.code_page = <%= node['php']['com.code_page'] %><% else %>;com.code_page=<% end %>

[mbstring]
; language for internal character representation.
; This affects mb_send_mail() and mbstring.detect_order.
; http://php.net/mbstring.language
<% if node['php']['mbstring.language'] != 'Japanese' %>mbstring.language = <%= node['php']['mbstring.language'] %><% else %>;mbstring.language = Japanese<% end %>

; Use of this INI entry is deprecated, use global internal_encoding instead.
; internal/script encoding.
; Some encoding cannot work as internal encoding. (e.g. SJIS, BIG5, ISO-2022-*)
; If empty, default_charset or internal_encoding or iconv.internal_encoding is used.
; The precedence is: default_charset < internal_encoding < iconv.internal_encoding
<% if !node['php']['mbstring.internal_encoding'].to_s.empty? %>mbstring.internal_encoding = <%= node['php']['mbstring.internal_encoding'] %><% else %>;mbstring.internal_encoding =<% end %>

; Use of this INI entry is deprecated, use global input_encoding instead.
; http input encoding.
; mbstring.encoding_traslation = On is needed to use this setting.
; If empty, default_charset or input_encoding or mbstring.input is used.
; The precedence is: default_charset < intput_encoding < mbsting.http_input
; http://php.net/mbstring.http-input
<% if !node['php']['mbstring.http_input'].to_s.empty? %>mbstring.http_input = <%= node['php']['mbstring.http_input'] %><% else %>;mbstring.http_input =<% end %>

; Use of this INI entry is deprecated, use global output_encoding instead.
; http output encoding.
; mb_output_handler must be registered as output buffer to function.
; If empty, default_charset or output_encoding or mbstring.http_output is used.
; The precedence is: default_charset < output_encoding < mbstring.http_output
; To use an output encoding conversion, mbstring's output handler must be set
; otherwise output encoding conversion cannot be performed.
; http://php.net/mbstring.http-output
<% if !node['php']['mbstring.http_output'].to_s.empty? %>mbstring.http_output = <%= node['php']['mbstring.http_output'] %><% else %>;mbstring.http_output =<% end %>

; enable automatic encoding translation according to
; mbstring.internal_encoding setting. Input chars are
; converted to internal encoding by setting this to On.
; Note: Do _not_ use automatic encoding translation for
;       portable libs/applications.
; http://php.net/mbstring.encoding-translation
<% if node['php']['mbstring.encoding_translation'] != 'Off' %>mbstring.encoding_translation = <%= node['php']['mbstring.encoding_translation'] %><% else %>;mbstring.encoding_translation = Off<% end %>

; automatic encoding detection order.
; "auto" detect order is changed according to mbstring.language
; http://php.net/mbstring.detect-order
<% if node['php']['mbstring.detect_order'] != 'auto' %>mbstring.detect_order = <%= node['php']['mbstring.detect_order'] %><% else %>;mbstring.detect_order = auto<% end %>

; substitute_character used when character cannot be converted
; one from another
; http://php.net/mbstring.substitute-character
<% if node['php']['mbstring.substitute_character'] != 'none' %>mbstring.substitute_character = <%= node['php']['mbstring.substitute_character'] %><% else %>;mbstring.substitute_character = none<% end %>

; overload(replace) single byte functions by mbstring functions.
; mail(), ereg(), etc are overloaded by mb_send_mail(), mb_ereg(),
; etc. Possible values are 0,1,2,4 or combination of them.
; For example, 7 for overload everything.
; 0: No overload
; 1: Overload mail() function
; 2: Overload str*() functions
; 4: Overload ereg*() functions
; http://php.net/mbstring.func-overload
<% if node['php']['mbstring.func_overload'] != 0 %>mbstring.func_overload = <%= node['php']['mbstring.func_overload'] %><% else %>;mbstring.func_overload = 0<% end %>

; enable strict encoding detection.
; Default: Off
<% if node['php']['mbstring.strict_detection'] != 'On' %>mbstring.strict_detection = <%= node['php']['mbstring.strict_detection'] %><% else %>;mbstring.strict_detection = On<% end %>

; This directive specifies the regex pattern of content types for which mb_output_handler()
; is activated.
; Default: mbstring.http_output_conv_mimetype=^(text/|application/xhtml\+xml)
<% if !node['php']['mbstring.http_output_conv_mimetype'].to_s.empty? %>mbstring.http_output_conv_mimetype = <%= node['php']['mbstring.http_output_conv_mimetype'] %><% else %>;mbstring.http_output_conv_mimetype=<% end %>

[gd]
; Tell the jpeg decode to ignore warnings and try to create
; a gd image. The warning will then be displayed as notices
; disabled by default
; http://php.net/gd.jpeg-ignore-warning
<% if node['php']['gd.jpeg_ignore_warning'] != 0 %>gd.jpeg_ignore_warning = <%= node['php']['gd.jpeg_ignore_warning'] %><% else %>;gd.jpeg_ignore_warning = 0<% end %>

[exif]
; Exif UNICODE user comments are handled as UCS-2BE/UCS-2LE and JIS as JIS.
; With mbstring support this will automatically be converted into the encoding
; given by corresponding encode setting. When empty mbstring.internal_encoding
; is used. For the decode settings you can distinguish between motorola and
; intel byte order. A decode setting cannot be empty.
; http://php.net/exif.encode-unicode
<% if node['php']['exif.encode_unicode'] != 'ISO-8859-15' %>exif.encode_unicode = <%= node['php']['exif.encode_unicode'] %><% else %>;exif.encode_unicode = ISO-8859-15<% end %>

; http://php.net/exif.decode-unicode-motorola
<% if node['php']['exif.decode_unicode_motorola'] != 'UCS-2BE' %>exif.decode_unicode_motorola = <%= node['php']['exif.decode_unicode_motorola'] %><% else %>;exif.decode_unicode_motorola = UCS-2BE<% end %>

; http://php.net/exif.decode-unicode-intel
<% if node['php']['exif.decode_unicode_intel'] != 'UCS-2LE' %>exif.decode_unicode_intel = <%= node['php']['exif.decode_unicode_intel'] %><% else %>;exif.decode_unicode_intel    = UCS-2LE<% end %>

; http://php.net/exif.encode-jis
<% if !node['php']['exif.encode_jis'].to_s.empty? %>exif.encode_jis = <%= node['php']['exif.encode_jis'] %><% else %>;exif.encode_jis =<% end %>

; http://php.net/exif.decode-jis-motorola
<% if node['php']['exif.decode_jis_motorola'] != 'JIS' %>exif.decode_jis_motorola = <%= node['php']['exif.decode_jis_motorola'] %><% else %>;exif.decode_jis_motorola = JIS<% end %>

; http://php.net/exif.decode-jis-intel
<% if node['php']['exif.decode_jis_intel'] != 'JIS' %>exif.decode_jis_intel = <%= node['php']['exif.decode_jis_intel'] %><% else %>;exif.decode_jis_intel    = JIS<% end %>

[Tidy]
; The path to a default tidy configuration file to use when using tidy
; http://php.net/tidy.default-config
<% if node['php']['tidy.default_config'] != '/usr/local/lib/php/default.tcfg' %>tidy.default_config = <%= node['php']['tidy.default_config'] %><% else %>;tidy.default_config = /usr/local/lib/php/default.tcfg<% end %>

; Should tidy clean and repair output automatically?
; WARNING: Do not use this option if you are generating non-html content
; such as dynamic images
; http://php.net/tidy.clean-output
tidy.clean_output = <%= node['php']['tidy.clean_output'] %>

[soap]
; Enables or disables WSDL caching feature.
; http://php.net/soap.wsdl-cache-enabled
soap.wsdl_cache_enabled=<%= node['php']['soap.wsdl_cache_enabled'] %>

; Sets the directory name where SOAP extension will put cache files.
; http://php.net/soap.wsdl-cache-dir
soap.wsdl_cache_dir="<%= node['php']['soap.wsdl_cache_dir'] %>"

; (time to live) Sets the number of second while cached file will be used
; instead of original one.
; http://php.net/soap.wsdl-cache-ttl
soap.wsdl_cache_ttl=<%= node['php']['soap.wsdl_cache_ttl'] %>

; Sets the size of the cache limit. (Max. number of WSDL files to cache)
soap.wsdl_cache_limit = <%= node['php']['soap.wsdl_cache_limit'] %>

[sysvshm]
; A default size of the shared memory segment
<% if node['php']['sysvshm.init_mem'] != 10000 %>sysvshm.init_mem = <%= node['php']['sysvshm.init_mem'] %><% else %>;sysvshm.init_mem = 10000<% end %>

[ldap]
; Sets the maximum number of open links or -1 for unlimited.
ldap.max_links = <%= node['php']['ldap.max_links'] %>

[mcrypt]
; For more information about mcrypt settings see http://php.net/mcrypt-module-open

; Directory where to load mcrypt algorithms
; Default: Compiled in into libmcrypt (usually /usr/local/lib/libmcrypt)
<% if !node['php']['mcrypt.algorithms_dir'].to_s.empty? %>mcrypt.algorithms_dir = <%= node['php']['mcrypt.algorithms_dir'] %><% else %>;mcrypt.algorithms_dir=<% end %>

; Directory where to load mcrypt modes
; Default: Compiled in into libmcrypt (usually /usr/local/lib/libmcrypt)
<% if !node['php']['mcrypt.modes_dir'].to_s.empty? %>mcrypt.modes_dir = <%= node['php']['mcrypt.modes_dir'] %><% else %>;mcrypt.modes_dir=<% end %>

[dba]
<% if !node['php']['dba.default_handler'].to_s.empty? %>dba.default_handler = <%= node['php']['dba.default_handler'] %><% else %>;dba.default_handler=<% end %>

[opcache]
; Determines if Zend OPCache is enabled
<% if node['php']['opcache.enable'] != 0 %>opcache.enable = <%= node['php']['opcache.enable'] %><% else %>;opcache.enable=0<% end %>

; Determines if Zend OPCache is enabled for the CLI version of PHP
<% if node['php']['opcache.enable_cli'] != 0 %>opcache.enable_cli = <%= node['php']['opcache.enable_cli'] %><% else %>;opcache.enable_cli=0<% end %>

; The OPcache shared memory storage size.
<% if node['php']['opcache.memory_consumption'] != 64 %>opcache.memory_consumption = <%= node['php']['opcache.memory_consumption'] %><% else %>;opcache.memory_consumption=64<% end %>

; The amount of memory for interned strings in Mbytes.
<% if node['php']['opcache.interned_strings_buffer'] != 4 %>opcache.interned_strings_buffer = <%= node['php']['opcache.interned_strings_buffer'] %><% else %>;opcache.interned_strings_buffer=4<% end %>

; The maximum number of keys (scripts) in the OPcache hash table.
; Only numbers between 200 and 100000 are allowed.
<% if node['php']['opcache.max_accelerated_files'] != 2000 %>opcache.max_accelerated_files = <%= node['php']['opcache.max_accelerated_files'] %><% else %>;opcache.max_accelerated_files=2000<% end %>

; The maximum percentage of "wasted" memory until a restart is scheduled.
<% if node['php']['opcache.max_wasted_percentage'] != 5 %>opcache.max_wasted_percentage = <%= node['php']['opcache.max_wasted_percentage'] %><% else %>;opcache.max_wasted_percentage=5<% end %>

; When this directive is enabled, the OPcache appends the current working
; directory to the script key, thus eliminating possible collisions between
; files with the same name (basename). Disabling the directive improves
; performance, but may break existing applications.
<% if node['php']['opcache.use_cwd'] != 1 %>opcache.use_cwd = <%= node['php']['opcache.use_cwd'] %><% else %>;opcache.use_cwd=1<% end %>

; When disabled, you must reset the OPcache manually or restart the
; webserver for changes to the filesystem to take effect.
<% if node['php']['opcache.validate_timestamps'] != 1 %>opcache.validate_timestamps = <%= node['php']['opcache.validate_timestamps'] %><% else %>;opcache.validate_timestamps=1<% end %>

; How often (in seconds) to check file timestamps for changes to the shared
; memory storage allocation. ("1" means validate once per second, but only
; once per request. "0" means always validate)
<% if node['php']['opcache.revalidate_freq'] != 2 %>opcache.revalidate_freq = <%= node['php']['opcache.revalidate_freq'] %><% else %>;opcache.revalidate_freq=2<% end %>

; Enables or disables file search in include_path optimization
<% if node['php']['opcache.revalidate_path'] != 0 %>opcache.revalidate_path = <%= node['php']['opcache.revalidate_path'] %><% else %>;opcache.revalidate_path=0<% end %>

; If disabled, all PHPDoc comments are dropped from the code to reduce the
; size of the optimized code.
<% if node['php']['opcache.save_comments'] != 1 %>opcache.save_comments = <%= node['php']['opcache.save_comments'] %><% else %>;opcache.save_comments=1<% end %>

; If enabled, a fast shutdown sequence is used for the accelerated code
<% if node['php']['opcache.fast_shutdown'] != 0 %>opcache.fast_shutdown = <%= node['php']['opcache.fast_shutdown'] %><% else %>;opcache.fast_shutdown=0<% end %>

; Allow file existence override (file_exists, etc.) performance feature.
<% if node['php']['opcache.enable_file_override'] != 0 %>opcache.enable_file_override = <%= node['php']['opcache.enable_file_override'] %><% else %>;opcache.enable_file_override=0<% end %>

; A bitmask, where each bit enables or disables the appropriate OPcache
; passes
<% if node['php']['opcache.optimization_level'] != '0xffffffff' %>opcache.optimization_level = <%= node['php']['opcache.optimization_level'] %><% else %>;opcache.optimization_level=0xffffffff<% end %>

<% if node['php']['opcache.inherited_hack'] != 1 %>opcache.inherited_hack = <%= node['php']['opcache.inherited_hack'] %><% else %>;opcache.inherited_hack=1<% end %>
<% if node['php']['opcache.dups_fix'] != 0 %>opcache.dups_fix = <%= node['php']['opcache.dups_fix'] %><% else %>;opcache.dups_fix=0<% end %>

; The location of the OPcache blacklist file (wildcards allowed).
; Each OPcache blacklist file is a text file that holds the names of files
; that should not be accelerated. The file format is to add each filename
; to a new line. The filename may be a full path or just a file prefix
; (i.e., /var/www/x  blacklists all the files and directories in /var/www
; that start with 'x'). Line starting with a ; are ignored (comments).
<% if !node['php']['opcache.blacklist_filename'].to_s.empty? %>opcache.blacklist_filename = <%= node['php']['opcache.blacklist_filename'] %><% else %>;opcache.blacklist_filename=<% end %>

; Allows exclusion of large files from being cached. By default all files
; are cached.
<% if node['php']['opcache.max_file_size'] != 0 %>opcache.max_file_size = <%= node['php']['opcache.max_file_size'] %><% else %>;opcache.max_file_size=0<% end %>

; Check the cache checksum each N requests.
; The default value of "0" means that the checks are disabled.
<% if node['php']['opcache.consistency_checks'] != 0 %>opcache.consistency_checks = <%= node['php']['opcache.consistency_checks'] %><% else %>;opcache.consistency_checks=0<% end %>

; How long to wait (in seconds) for a scheduled restart to begin if the cache
; is not being accessed.
<% if node['php']['opcache.force_restart_timeout'] != 180 %>opcache.force_restart_timeout = <%= node['php']['opcache.force_restart_timeout'] %><% else %>;opcache.force_restart_timeout=180<% end %>

; OPcache error_log file name. Empty string assumes "stderr".
<% if !node['php']['opcache.error_log'].to_s.empty? %>opcache.error_log = <%= node['php']['opcache.error_log'] %><% else %>;opcache.error_log=<% end %>

; All OPcache errors go to the Web server log.
; By default, only fatal errors (level 0) or errors (level 1) are logged.
; You can also enable warnings (level 2), info messages (level 3) or
; debug messages (level 4).
<% if node['php']['opcache.log_verbosity_level'] != 1 %>opcache.log_verbosity_level = <%= node['php']['opcache.log_verbosity_level'] %><% else %>;opcache.log_verbosity_level=1<% end %>

; Preferred Shared Memory back-end. Leave empty and let the system decide.
<% if !node['php']['opcache.preferred_memory_model'].to_s.empty? %>opcache.preferred_memory_model = <%= node['php']['opcache.preferred_memory_model'] %><% else %>;opcache.preferred_memory_model=<% end %>

; Protect the shared memory from unexpected writing during script execution.
; Useful for internal debugging only.
<% if node['php']['opcache.protect_memory'] != 0 %>opcache.protect_memory = <%= node['php']['opcache.protect_memory'] %><% else %>;opcache.protect_memory=0<% end %>

; Allows calling OPcache API functions only from PHP scripts which path is
; started from specified string. The default "" means no restriction
<% if !node['php']['opcache.restrict_api'].to_s.empty? %>opcache.restrict_api = <%= node['php']['opcache.restrict_api'] %><% else %>;opcache.restrict_api=<% end %>

; Mapping base of shared memory segments (for Windows only). All the PHP
; processes have to map shared memory into the same address space. This
; directive allows to manually fix the "Unable to reattach to base address"
; errors.
<% if !node['php']['opcache.mmap_base'].to_s.empty? %>opcache.mmap_base = <%= node['php']['opcache.mmap_base'] %><% else %>;opcache.mmap_base=<% end %>

; Enables and sets the second level cache directory.
; It should improve performance when SHM memory is full, at server restart or
; SHM reset. The default "" disables file based caching.
<% if !node['php']['opcache.file_cache'].to_s.empty? %>opcache.file_cache = <%= node['php']['opcache.file_cache'] %><% else %>;opcache.file_cache=<% end %>

; Enables or disables opcode caching in shared memory.
<% if node['php']['opcache.file_cache_only'] != 0 %>opcache.file_cache_only = <%= node['php']['opcache.file_cache_only'] %><% else %>;opcache.file_cache_only=0<% end %>

; Enables or disables checksum validation when script loaded from file cache.
<% if node['php']['opcache.file_cache_consistency_checks'] != 1 %>opcache.file_cache_consistency_checks = <%= node['php']['opcache.file_cache_consistency_checks'] %><% else %>;opcache.file_cache_consistency_checks=1<% end %>

; Implies opcache.file_cache_only=1 for a certain process that failed to
; reattach to the shared memory (for Windows only). Explicitly enabled file
; cache is required.
<% if node['php']['opcache.file_cache_fallback'] != 1 %>opcache.file_cache_fallback = <%= node['php']['opcache.file_cache_fallback'] %><% else %>;opcache.file_cache_fallback=1<% end %>

; Enables or disables copying of PHP code (text segment) into HUGE PAGES.
; This should improve performance, but requires appropriate OS configuration.
<% if node['php']['opcache.huge_code_pages'] != 1 %>opcache.huge_code_pages = <%= node['php']['opcache.huge_code_pages'] %><% else %>;opcache.huge_code_pages=1<% end %>

[curl]
; A default value for the CURLOPT_CAINFO option. This is required to be an
; absolute path.
<% if !node['php']['curl.cainfo'].to_s.empty? %>curl.cainfo = <%= node['php']['curl.cainfo'] %><% else %>;curl.cainfo =<% end %>

[openssl]
; The location of a Certificate Authority (CA) file on the local filesystem
; to use when verifying the identity of SSL/TLS peers. Most users should
; not specify a value for this directive as PHP will attempt to use the
; OS-managed cert stores in its absence. If specified, this value may still
; be overridden on a per-stream basis via the "cafile" SSL stream context
; option.
<% if !node['php']['openssl.cafile'].to_s.empty? %>openssl.cafile = <%= node['php']['openssl.cafile'] %><% else %>;openssl.cafile=<% end %>

; If openssl.cafile is not specified or if the CA file is not found, the
; directory pointed to by openssl.capath is searched for a suitable
; certificate. This value must be a correctly hashed certificate directory.
; Most users should not specify a value for this directive as PHP will
; attempt to use the OS-managed cert stores in its absence. If specified,
; this value may still be overridden on a per-stream basis via the "capath"
; SSL stream context option.
<% if !node['php']['openssl.capath'].to_s.empty? %>openssl.capath = <%= node['php']['openssl.capath'] %><% else %>;openssl.capath=<% end %>

; Local Variables:
; tab-width: 4
; End: