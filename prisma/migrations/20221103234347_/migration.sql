-- DropForeignKey
ALTER TABLE "TrackedArtist" DROP CONSTRAINT "TrackedArtist_artistId_fkey";

-- DropForeignKey
ALTER TABLE "TrackedArtist" DROP CONSTRAINT "TrackedArtist_userId_fkey";

-- AddForeignKey
ALTER TABLE "TrackedArtist" ADD CONSTRAINT "TrackedArtist_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("spotifyId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TrackedArtist" ADD CONSTRAINT "TrackedArtist_artistId_fkey" FOREIGN KEY ("artistId") REFERENCES "Artist"("spotifyId") ON DELETE RESTRICT ON UPDATE CASCADE;
