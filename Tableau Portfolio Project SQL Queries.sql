-- 1

Select SUM(cast(new_cases as float)) as total_cases, SUM(cast(new_deaths as float)) as total_deaths, SUM(cast(total_deaths as float)) / SUM(cast(total_cases as float))*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
Where continent is not null
order by 1, 2


-- 2

Select continent, SUM(cast(new_deaths as float)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
Where continent is not null
Group by continent
Order by TotalDeathCount desc


--3

Select Location, Population, MAX(cast(total_cases as float)) as HighestInfectionCount, MAX((cast(total_cases as float)/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths$
Where continent is not null
Group by Location, Population
Order by PercentPopulationInfected desc

--4

Select Location, Population, date, MAX(total_cases) as HighestInfectionCount,  MAX((cast(total_cases as float)/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths$
Group by Location, Population, date
order by PercentPopulationInfected desc