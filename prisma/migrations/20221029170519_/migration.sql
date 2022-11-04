/*
  Warnings:

  - You are about to drop the column `artistId` on the `Event` table. All the data in the column will be lost.
  - Added the required column `description` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Added the required column `url` to the `Event` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Event" DROP CONSTRAINT "Event_artistId_fkey";

-- AlterTable
ALTER TABLE "Event" DROP COLUMN "artistId",
ADD COLUMN     "description" VARCHAR(255) NOT NULL,
ADD COLUMN     "url" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "ArtistOnEvent" (
    "artistId" TEXT NOT NULL,
    "eventId" TEXT NOT NULL,

    CONSTRAINT "ArtistOnEvent_pkey" PRIMARY KEY ("artistId","eventId")
);

-- AddForeignKey
ALTER TABLE "ArtistOnEvent" ADD CONSTRAINT "ArtistOnEvent_artistId_fkey" FOREIGN KEY ("artistId") REFERENCES "Artist"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ArtistOnEvent" ADD CONSTRAINT "ArtistOnEvent_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "Event"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
