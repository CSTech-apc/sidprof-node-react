-- CreateTable
CREATE TABLE `permissions` (
    `id` VARCHAR(191) NOT NULL,
    `permInst` BOOLEAN NOT NULL DEFAULT false,
    `permUser` BOOLEAN NOT NULL DEFAULT false,
    `permStudEnrol` BOOLEAN NOT NULL DEFAULT false,
    `permCalend` BOOLEAN NOT NULL DEFAULT false,
    `permSysEval` BOOLEAN NOT NULL DEFAULT false,
    `permSysFreq` BOOLEAN NOT NULL DEFAULT false,
    `permMatrixDisc` BOOLEAN NOT NULL DEFAULT false,
    `permDisc` BOOLEAN NOT NULL DEFAULT false,
    `permClassDiary` BOOLEAN NOT NULL DEFAULT false,
    `userId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `periods` (
    `id` VARCHAR(191) NOT NULL,
    `year` VARCHAR(10) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    FULLTEXT INDEX `periods_year_idx`(`year`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `licenses` (
    `id` VARCHAR(191) NOT NULL,
    `institution` VARCHAR(255) NOT NULL,
    `cnpj` VARCHAR(14) NOT NULL,
    `inep` VARCHAR(8) NOT NULL,
    `dateInit` VARCHAR(10) NOT NULL,
    `dateFin` VARCHAR(10) NOT NULL,
    `status` CHAR(3) NOT NULL DEFAULT 'ACT',
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `periodId` VARCHAR(191) NOT NULL,

    FULLTEXT INDEX `licenses_institution_cnpj_inep_idx`(`institution`, `cnpj`, `inep`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE FULLTEXT INDEX `users_name_email_profile_idx` ON `users`(`name`, `email`, `profile`);

-- AddForeignKey
ALTER TABLE `permissions` ADD CONSTRAINT `permissions_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `users`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `licenses` ADD CONSTRAINT `licenses_periodId_fkey` FOREIGN KEY (`periodId`) REFERENCES `periods`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
