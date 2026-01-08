
cp_hghl()
{
    mkdir -p $1
    cp queries/highlights.scm $1

}

cp_hghl ~/.config/nvim/queries/snug
cp_hghl ~/.local/share/nvim/queries/snug

if [ -d ~/.local/share/lunarvim ]; then
    cp_hghl ~/.local/share/lunarvim/site/pack/lazy/opt/nvim-treesitter/queries/snug/
fi
