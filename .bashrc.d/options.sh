# shellcheck disable=SC2148

# Command name that is the name of a directory is executed
# as if it were the argument to the cd command. This option
# is only used by interactive shells.
shopt -s autocd

# Minor errors in the spelling of a directory component in a
# cd command will be corrected. The errors checked for are
# transposed characters, a missing character, and a character
# too many. If a correction is found, the corrected path is
# printed, and the command proceeds. This option is only
# used by interactive shells.
shopt -s cdspell

# Check that a command found in the hash table exists before
# trying to execute it. If a hashed command no longer exists,
# a normal path search is performed.
shopt -s checkhash

# Attempt spelling correction on directory names during word
# completion if the directory name initially supplied does not
# exist.
shopt -s dirspell

# Include filenames beginning with a `.` in the results of
# filename expansion. The filenames `.` and `..` must always
# be matched explicitly, even if dotglob is set.
shopt -s dotglob

# Use extended pattern matching features.
shopt -s extglob

# The pattern ‘**’ used in a filename expansion context will match
# all files and zero or more directories and subdirectories. If the
# pattern is followed by a ‘/’, only directories and subdirectories
# match.
shopt -s globstar

# The history list is appended to the file named by the value of the
# HISTFILE variable when the shell exits, rather than overwriting
# the file.
shopt -s histappend

# Give the user the opportunity to re-edit a failed history
# substitution.
shopt -s histreedit

# The results of history substitution are not immediately passed to
# the shell parser. Instead, the resulting line is loaded into the
# Readline editing buffer, allowing further modification.
shopt -s histverify

# Match filenames in a case-insensitive fashion when performing
# filename expansion.
shopt -s nocaseglob

# Treat a command name that doesn’t have any completions as a possible
# alias and attempt alias expansion. If it has an alias, Bash attempts
# programmable completion using the command word resulting from the
# expanded alias.
shopt -s progcomp_alias
