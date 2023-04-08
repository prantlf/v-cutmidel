import os
import strconv

const version = '1.0.0'

const hint = 'use -h to get help'

fn usage() {
	println('cutmidel ${version}
  Shortens a text by trimming it by an ellipsis in the middle.

Usage: cutmidel [options] <text> <leading> <trailing> [ellipsis]

  Specify the text and the maximum count of leading and trailing
  characters. The overall maximum length will be their sum plus
  the length of an ellipsis (3 dots by default). Zero for either
  leading or trailing count means no leading or trailing parts.

Options:
  -V|--version  prints the version of the executable and exits
  -h|--help     prints th usage information and exits

Examples:
  $ cutmidel "~/Sources/private/cutmidel" 5 10
  ~/Sou...e/cutmidel
  $ cutmidel ~/Sources/private/cutmidel 0 12 ..
  ..ate/cutmidel')
}

fn main() {
	argc := os.args.len
	// print usage information if no arguments were provided
	if argc == 1 {
		usage()
		exit(1)
	}
	// check if printing the version number or usage information was requested
	if argc == 2 {
		arg := os.args[1]
		if arg == '-V' || arg == '--version' {
			println(version)
			exit(0)
		}
		if arg == '-h' || arg == '--help' {
			usage()
			exit(0)
		}
		// unexpected one argument or fail if unexpected arguments were not provided
		println('invalid argument: ${arg} (${hint})')
		exit(1)
	}
	// check if exactly three arguments are available
	if argc == 3 {
		println('too few arguments (${hint})')
		exit(1)
	}
	if argc > 5 {
		println('too many arguments (${hint})')
		exit(1)
	}

	// make sure that leading and trailing character count are numeric
	lead := strconv.atoi(os.args[2]) or {
		println('invalid leading character count: "${os.args[2]}" (${hint})')
		exit(1)
	}
	trail := strconv.atoi(os.args[3]) or {
		println('invalid trailing character count: "${os.args[3]}" (${hint})')
		exit(1)
	}
	// ellipsis cannot be put to the middle unless the middle is specified
	if lead == 0 && trail == 0 {
		println('both leading and trailing counts cannot be zero (${hint})')
		exit(1)
	}
	// check if a custom ellipsis was specified
	mut ellipsis := '...'
	if argc == 5 {
		ellipsis = os.args[4]
	}
	elliplen := ellipsis.len

	// get the text to trim with its length; it will be trimmed in-place
	mut txt := os.args[1]
	txtlen := txt.len

	// if the input text is shorter than the ledting and trailing character
	// count plus the ellipsis length, leave it intact
	if txtlen > lead + trail + elliplen {
		if lead == 0 {
			// if only the trailing part should be displayed, put the ellipsis
			// to the beginning and move the trailing part behind it
			txt = ellipsis + txt[txtlen - trail..]
		} else if trail == 0 {
			// if only the leading part should be displayed, put the ellipsis
			// right behind it
			txt = txt[..lead] + ellipsis
		} else {
			// if both leading and trailing parts should be displayed, put the
			// ellipsis behind the leading part and move the trailing part behind it
			txt = txt[..lead] + ellipsis + txt[txtlen - trail..]
		}
	}

	print(txt)
}
