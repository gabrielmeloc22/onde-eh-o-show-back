/*
  Warnings:

  - You are about to drop the column `configId` on the `Artist` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Artist" DROP CONSTRAINT "Artist_configId_fkey";

-- AlterTable
ALTER TABLE "Artist" DROP COLUMN "configId";

-- CreateTable
CREATE TABLE "ArtistNotification" (
    "configId" TEXT NOT NULL,
    "artistId" TEXT NOT NULL,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "assignedBy" TEXT NOT NULL,

    CONSTRAINT "ArtistNotification_pkey" PRIMARY KEY ("artistId","configId")
);

-- AddForeignKey
ALTER TABLE "ArtistNotification" ADD CONSTRAINT "ArtistNotification_configId_fkey" FOREIGN KEY ("configId") REFERENCES "Config"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ArtistNotification" ADD CONSTRAINT "ArtistNotification_artistId_fkey" FOREIGN KEY ("artistId") REFERENCES "Artist"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
