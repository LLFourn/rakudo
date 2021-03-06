class CompUnit::Repository::Perl5 does CompUnit::Repository {
    method need(
        CompUnit::DependencySpecification $spec,
        CompUnit::PrecompilationRepository $precomp = self.precomp-repository(),
    )
        returns CompUnit:D
    {
        if $spec.from eq 'Perl5' {
            require Inline::Perl5;
            my $perl5 = ::('Inline::Perl5').default_perl5;

            if $*RAKUDO_MODULE_DEBUG -> $RMD {
                $RMD("Loading {$spec.short-name} via Inline::Perl5");
            }
            $perl5.require(
                $spec.short-name,
                $spec.version-matcher !== True ?? $spec.version-matcher.Num !! Num,
            );
            return CompUnit.new(
                :short-name($spec.short-name),
                :handle(CompUnit::Handle.from-unit(::($spec.short-name).WHO)),
                :repo(self),
                :repo-id($spec.short-name),
                :from($spec.from),
            );

            CATCH {
                when X::CompUnit::UnsatisfiedDependency {
                    X::NYI::Available.new(:available('Inline::Perl5'), :feature('Perl 5')).throw;
                }
            }
        }

        return self.next-repo.need($spec, $precomp) if self.next-repo;
        X::CompUnit::UnsatisfiedDependency.new(:specification($spec)).throw;
    }

    method loaded() {
        []
    }

    method id() {
        'Perl5'
    }

    method path-spec() {
        'perl5#'
    }
}

# vim: ft=perl6 expandtab sw=4
