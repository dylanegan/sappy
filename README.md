# sappy

## Description:

A ruby library providing a wrapper around the SiteUptime API.

## Installation:

    gem install sappy -s http://gemcutter.org

## Usage: 

    require 'rubygems'
    require 'sappy'

    @account = Sappy::Account.login('email@email.com', 'password')

    monitors = @account.monitors
    monitor = monitors.first
    monitor.disable

    monitor = @account.add_monitor(...)

## License:

(The MIT License)

Copyright (c) 2008-2009 Dylan Egan, Tim Carey-Smith

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the 'Software'), to deal in
the Software without restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWAge, publish, distribute, sublicense, and/or sell
