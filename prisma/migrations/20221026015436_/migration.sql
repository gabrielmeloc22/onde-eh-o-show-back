/*
  Warnings:

  - You are about to drop the column `userId` on the `Artist` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Artist" DROP CONSTRAINT "Artist_userId_fkey";

-- AlterTable
ALTER TABLE "Artist" DROP COLUMN "userId";

-- CreateTable
CREATE TABLE "TrackedArtist" (
    "id" TEXT NOT NULL,
    "userId" TEXT,
    "artistId" TEXT,

    CONSTRAINT "TrackedArtist_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "TrackedArtist" ADD CONSTRAINT "TrackedArtist_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TrackedArtist" ADD CONSTRAINT "TrackedArtist_artistId_fkey" FOREIGN KEY ("artistId") REFERENCES "Artist"("id") ON DELETE SET NULL ON UPDATE CASCADE;
