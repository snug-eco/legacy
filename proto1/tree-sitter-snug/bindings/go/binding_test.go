package tree_sitter_snug_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_snug "github.com/snugl/tree-sitter-snug.git/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_snug.Language())
	if language == nil {
		t.Errorf("Error loading Snug grammar")
	}
}
