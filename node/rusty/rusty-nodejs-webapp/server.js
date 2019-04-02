'use strict';
var http = require('http');
var port = 4889;

const Discord = require('discord.js');
const client = new Discord.Client();

var _console = '--- start of console ---<br><br>server initializated<br>';
var prefix = "r[";
var header = "<html><head><style>" +
    "html {font-family: monospace; background-color: black; color: white; text-align: center;} a {display: none;} button {border-style: none solid;background: none;box-shadow: none;border-radius: 0px;border-width:2px;border-color: aqua;color:aqua;cursor:pointer;font-family:monospace;padding-left:0.75em;padding-right:0.75em;margin-top:.2em;margin-bottom:.2em; }" +
    "</style></head><body>";
var old_pre = prefix;
var navigator = 'quick history nav<br><button onclick="window.history.back()"> < </button> * <button onclick="window.history.forward()"> > </button>';

//http

var server = http.createServer(function(req, res) {
    if (req.url == "/") {
        write(function() {
            res.write('rusty node.js app main page<br><br>' +
                'table of contents:<br>' +
                '<button onclick="window.location.assign(`/console`)"><strong>/console</strong></button><br>' +
                '<button onclick="window.location.assign(`/prefix`)"><strong>/prefix</strong></button><br>' +
                '<button onclick="window.location.assign(`/stats`)"><strong>/stats</strong></button><br><br>' + navigator);
        });
    } else if (req.url == "/console") {
        write(function() {
            res.write('rusty node.js app console page <button onclick="window.location.assign(`../console`)">reload console</button><br><br>');
            res.write(_console);
            res.write("<br>--- end of console ---<br><br>" + navigator);
        });
    } else if (req.url == "/prefix") {
        write(function() {
            res.write('rusty node.js app prefix page <button onclick="window.location.assign(`../prefix`)">reload</button><br><br><strong>current prefix: *' + prefix + '*</strong><br><br><button onclick="window.location.assign(`../newprefix=` + prompt(`new prefix`));">change</button><br><br>');
            res.write(navigator);
        });
    } else if (req.url.indexOf("/newprefix=") != -1) {
        old_pre = prefix;
        prefix = decodeURIComponent(req.url.replace("/newprefix=", ""));
        _console += "<strong>prefix change:</strong> *<strong>" + old_pre + "</strong>* to *<strong>" + prefix + "</strong>*<br>";
        write(function() {
            res.write("success!<br><br>");
            res.write("<button onclick='window.history.back()'>go back</button>")
        });
    } else if (req.url == "/stats") {
        write(function() {
            res.write('rusty node.js app stats page<br><br>' +
                'ping: ' + client.ping + "ms (" + client.ping / 1000 + "sec)" +
                '<br><br>' + navigator);
        });
    } else {
        write(function() {
            res.write('rusty node.js app invalid page<br><br><strong>404</strong><br><br>');
            res.write(navigator);
        });
    }

    function write(fallback) {
        res.write(header);
        fallback();
        res.write('</body></html>');
        res.end();
    }

}).listen(port);

//discord

client.on('ready', () => {
    _console += `logged in as ${client.user.tag}<br>`;
});

client.on('message', msg => {
    _console += "<span style='color: #7f7f7f;'><strong>msg:</strong> " + msg.author.tag + ": " + msg.content + "</span><br>";
    if (msg.content === prefix + 'ping') {
        msg.reply('pong');
        _console += "<strong>command: </strong> ping<br>";
    } else if (msg.content === prefix + 'poke') {
        msg.channel.send('ayy what');
        _console += "<strong>command: </strong> poke<br>";
    }
});

client.login('<DISCORD TOKEN HERE. I KNOW THAT THIS IS BAD DESIGN BUT I KINDA WENT FUCK IT CODING THIS>');