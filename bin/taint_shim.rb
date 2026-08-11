# Local-development shim only -- loaded via RUBYOPT by bin/serve.
#
# The `github-pages` gem pins Liquid 4.0.3, which still calls Object#tainted?.
# That method was removed in Ruby 3.2, so `bundle exec jekyll` crashes on any
# modern Ruby. Restoring it as a no-op is safe: object tainting has had no
# effect since Ruby 2.7.
#
# This cannot live in _plugins/, because the github-pages gem forces Jekyll's
# --safe mode to mirror production, and safe mode never loads custom plugins.
# GitHub Pages builds the deployed site with its own Ruby, so this file has no
# effect on production.

if RUBY_VERSION >= "3.2"
  class Object
    def tainted?
      false
    end

    def taint
      self
    end

    def untaint
      self
    end
  end
end
