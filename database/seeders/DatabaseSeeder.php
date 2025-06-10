<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            MonthSeeder::class
        ]);
        // User::factory(10)->create();

        User::factory()->create([
            'name' => 'Antonio Aguilar',
            'email' => 'a@a.com',
            'mobile' => '1122334455',
            'password' => bcrypt('1'),
            'utype' => 'ADM',
        ]);
    }
}
