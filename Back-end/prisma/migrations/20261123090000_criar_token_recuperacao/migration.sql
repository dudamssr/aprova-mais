
CREATE TABLE `tokens_recuperacao` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `token` VARCHAR(191) NOT NULL,
    `expiracao` DATETIME(3) NOT NULL,
    `utilizado` BOOLEAN NOT NULL DEFAULT false,
    `usuarioId` INTEGER NOT NULL,

    UNIQUE INDEX `tokens_recuperacao_token_key` (`token`),
    INDEX `tokens_recuperacao_usuarioId_idx` (`usuarioId`),
    PRIMARY KEY (`id`),

    CONSTRAINT `tokens_recuperacao_usuarioId_fkey`
    FOREIGN KEY (`usuarioId`)
    REFERENCES `Usuario` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
