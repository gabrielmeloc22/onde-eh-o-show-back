/*
  Warnings:

  - You are about to drop the `UserConfig` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[userId]` on the table `Config` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `userId` to the `Config` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "UserConfig" DROP CONSTRAINT "UserConfig_configId_fkey";

-- DropForeignKey
ALTER TABLE "UserConfig" DROP CONSTRAINT "UserConfig_userId_fkey";

-- AlterTable
ALTER TABLE "Config" ADD COLUMN     "userId" TEXT NOT NULL;

-- DropTable
DROP TABLE "UserConfig";

-- CreateIndex
CREATE UNIQUE INDEX "Config_userId_key" ON "Config"("userId");

-- AddForeignKey
ALTER TABLE "Config" ADD CONSTRAINT "Config_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
