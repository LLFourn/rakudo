my class Nil is Cool { # declared in BOOTSTRAP
    method new(*@) { Nil }
    multi method gist(Nil:) { 'Nil' }
    method Numeric() { warn "Use of {self.gist} in numeric context"; 0 }
    method Str() { warn "Use of {self.gist} in string context"; '' }
    method sink(*@) { Nil }     # required by RESTRICTED setting

    method AT-POS(*@)     { Nil }
    method AT-KEY(*@)     { Nil }
#    method ACCEPTS(*@)    { Nil }  # XXX spec says Nil, but makes spectest hang

    method BIND-POS(*@)   { die "Attempted to BIND-POS to {self.gist}." }
    method BIND-KEY(*@)   { fail X::Bind.new(target => '{self.gist}') }
    method ASSIGN-POS(*@) { die "Attempted to ASSIGN-POS to {self.gist}." }
    method ASSIGN-KEY(*@) { die "Attempted to ASSIGN-KEY to {self.gist}." }
    method STORE(*@)      { die "Attempted to STORE to {self.gist}." }
    method push(*@)    is nodal { die "Attempted to push to {self.gist}." }
    method append(*@)  is nodal { die "Attempted to append to {self.gist}." }
    method unshift(*@) is nodal { die "Attempted to unshift to {self.gist}." }
    method prepend(*@) is nodal { die "Attempted to prepend to {self.gist}." }
    method FALLBACK(*@)   { Nil }
}

# vim: ft=perl6 expandtab sw=4
