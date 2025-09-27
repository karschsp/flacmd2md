# FLAC Metadata to Markdown (flacmd2md)

This is a dumb bash script that traverses a bunch of folders of flac files and outputs album metadata information to a Markdown table.  
It is a very specific (aka "works on my machine") script.

Here's how it works. First of all, your FLAC folder needs to be structured by artist and album, so:

```
--Beatles, The
  -- Abbey Road
  -- Rubber Soul
--Oasis
  -- Definitely Maybe
  -- Be Here Now
```

etc etc.

Oh also, you should make sure your metatags are good. Use something like MusicBrainz Picard. Tagliness is close to godliness.

The script mostly uses the information from the folders to generate the markdown, but does read FLAC metadata for UPC codes, etc.

It then outputs it to a markdown file that looks something like this:

```
| Artist | Album | Year | UPC |
|--------|-------|------|-----|
10,000 Maniacs|[In My Tribe](https://musicbrainz.org/search?query=10%2C000+Maniacs+In+My+Tribe&type=release&method=advanced) [[Discogs](https://www.discogs.com/search/?q=075596073820&type=release)]|1987|075596073820
60 Foot Dolls|[The Big 3](https://musicbrainz.org/search?query=60+Foot+Dolls+The+Big+3&type=release&method=advanced) [[Discogs](https://www.discogs.com/search/?q=720642496626&type=release)]|1997-01-28|720642496626
Actual Tigers, The|[Gravelled & Green](https://musicbrainz.org/search?query=Actual+Tigers%2C+The+Gravelled+%26+Green&type=release&method=advanced) [[Discogs](https://www.discogs.com/search/?q=067003022224&type=release)]|2001|067003022224
Alanis Morissette|[Supposed Former Infatuation Junkie](https://musicbrainz.org/search?query=Alanis+Morissette+Supposed+Former+Infatuation+Junkie&type=release&method=advanced) [[Discogs](https://www.discogs.com/search/?q=766485589729&type=release)]|1998|766485589729
Alice in Chains|[Greatest Hits](https://musicbrainz.org/search?query=Alice+in+Chains+Greatest+Hits&type=release&method=advanced) [[Discogs](https://www.discogs.com/search/?q=5099750412367&type=release)]|2001|5099750412367
Allman Brothers Band, The|[At Fillmore East](https://musicbrainz.org/search?query=Allman+Brothers+Band%2C+The+At+Fillmore+East&type=release&method=advanced) [[Discogs](https://www.discogs.com/search/?q=4988011357879&type=release)]|1971|4988011357879
Andrew W.K.|[I Get Wet](https://musicbrainz.org/search?query=Andrew+W.K.+I+Get+Wet&type=release&method=advanced) [[Discogs](https://www.discogs.com/search/?q=731458658825&type=release)]|2001|731458658825
A Perfect Circle|[Mer de Noms](https://musicbrainz.org/search?query=A+Perfect+Circle+Mer+de+Noms&type=release&method=advanced) [[Discogs](https://www.discogs.com/search/?q=632427648123&type=release)]|2000-05-23|632427648123
Ash|[1977](https://musicbrainz.org/search?query=Ash+1977&type=release&method=advanced) [[Discogs](https://www.discogs.com/search/?q=4009880895528&type=release)]|1996|4009880895528
At the Drive-In|[Relationship of Command](https://musicbrainz.org/search?query=At+the+Drive-In+Relationship+of+Command&type=release&method=advanced) [[Discogs](https://www.discogs.com/search/?q=766482969548&type=release)]|2000|766482969548
Beach Boys, The|[The Greatest Hits; 20 Good Vibrations](https://musicbrainz.org/search?query=Beach+Boys%2C+The+The+Greatest+Hits%3B+20+Good+Vibrations&type=release&method=advanced) [[Discogs](https://www.discogs.com/search/?q=724382941828&type=release)]|1995|724382941828
Beastie Boys|[Paul's Boutique](https://musicbrainz.org/search?query=Beastie+Boys+Paul%27s+Boutique&type=release&method=advanced) [[Discogs](https://www.discogs.com/search/?q=077779174324&type=release)]|1989|077779174324
```

Then you can paste that puppy into anything that can handle markdown. Like Apple Notes! Or sforgy!
